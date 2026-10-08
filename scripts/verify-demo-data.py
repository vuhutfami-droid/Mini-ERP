#!/usr/bin/env python3
"""Validate fictional BA fixtures, not application behavior or legal accounting."""
import argparse
import csv
import json
import sys
from collections import Counter, defaultdict
from datetime import date, timedelta
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path


def rounded(value):
    return int(Decimal(value).quantize(Decimal('1'), rounding=ROUND_HALF_UP))


def minutes(clock):
    hour, minute = map(int, clock.split(':'))
    return hour * 60 + minute


def validate(folder):
    data = json.loads((folder / 'baseline.json').read_text())
    def rows(name):
        with (folder / name).open(newline='') as f:
            return list(csv.DictReader(f))
    people = rows('employees.csv')
    attendance = rows('attendance.csv')
    labor = rows('labor-intervals.csv')
    checks = 0
    def require(condition, message):
        nonlocal checks
        checks += 1
        if not condition:
            raise ValueError(message)
    def unique(items, field):
        require(len({x[field] for x in items}) == len(items), f'Duplicate {field}')
    def same(actual, expected, label):
        require(actual == expected, f'{label}: actual={actual}, expected={expected}')
    def no_overlap(items, label):
        intervals = sorted(items)
        for previous, current in zip(intervals, intervals[1:]):
            require(previous[1] <= current[0], f'Overlapping {label}')
    unique(people, 'employee_id')
    same(len(people), 50, 'People')
    same(Counter(p['department'] for p in people), dict(CEO=1, SALES=5, PURCHASE=2,
         WAREHOUSE=4, PRODUCTION=28, QUALITY=3, FINANCE=3, HR_ADMIN=4), 'Departments')
    employees = {p['employee_id']: p for p in people}
    same(sum(bool(p['account_role']) for p in people), data['roles_account_count'], 'Account roles')
    for p in people:
        require(p['manager_id'] in employees or p['employee_id'] == 'E001', 'Unknown manager')
        require(p['manager_id'] != p['employee_id'], 'Self manager')
    working = data['calendar']['working_dates']
    same(len(working), 26, 'Working days')
    same(working, [f'2026-09-{d:02}' for d in range(1, 31)
                   if date(2026, 9, d).weekday() != 6], 'Fictional calendar')
    same(data['calendar']['scheduled_minutes'], len(working) * 480, 'Scheduled minutes')
    unique(attendance, 'record_id')
    same(len(attendance), 50 * len(working), 'Attendance rows')
    actual_work = {}
    paid = defaultdict(int)
    for row in attendance:
        key = row['employee_id'], row['date']
        require(key not in actual_work and row['employee_id'] in employees and row['date'] in working,
                'Missing/duplicate/invalid person-day')
        require(row['confirmed_by'] in employees and row['confirmed_by'] != row['employee_id'],
                'Unknown/self attendance confirmer')
        worked, leave, unpaid = (int(row[k]) for k in
                                ('worked_minutes', 'paid_leave_minutes', 'unpaid_leave_minutes'))
        require(min(worked, leave, unpaid) >= 0, 'Negative attendance')
        same(worked + leave + unpaid, 480, 'Daily time reconciliation')
        actual_work[key] = worked
        paid[row['employee_id']] += worked + leave
    unique(labor, 'record_id')
    direct = defaultdict(int)
    direct_day = defaultdict(int)
    person_intervals = defaultdict(list)
    machine_intervals = defaultdict(set)
    batch_minutes = defaultdict(int)
    job_minutes = defaultdict(int)
    batches = {b['batch_id']: b for b in data['batches']}
    require(len(batches) == len(data['batches']), 'Duplicate batch')
    for row in labor:
        employee = employees[row['employee_id']]
        batch = batches[row['batch_id']]
        key = row['employee_id'], row['date']
        start, end = minutes(row['start']), minutes(row['end'])
        same(end - start, int(row['minutes']), 'Direct interval duration')
        require(start < end and ((480 <= start < end <= 720) or (780 <= start < end <= 1020)),
                'Work outside shift/lunch')
        require(employee['skill'] == ('tile_form_finish' if batch['batch_id'].startswith('N-')
                                     else 'terrazzo_form_finish'), 'Worker lacks skill')
        require(employee['safety_valid_through'] >= row['date'], 'Expired safety training')
        require(row['date'] == batch['start_date' if row['phase'] == 'form' else 'finish_date'],
                'Wrong phase date')
        require(row['job_id'] == batch['job_id'], 'Wrong labor job')
        require(row['confirmed_by'] != row['employee_id'], 'Self direct time confirmation')
        person_intervals[key].append((start, end))
        machine_intervals[(row['resource_id'], row['date'])].add((start, end, row['batch_id']))
        direct[row['employee_id']] += int(row['minutes'])
        direct_day[key] += int(row['minutes'])
        batch_minutes[row['batch_id']] += int(row['minutes'])
        job_minutes[row['job_id']] += int(row['minutes'])
    for key, intervals in person_intervals.items():
        no_overlap(intervals, f'person {key}')
        require(direct_day[key] <= actual_work[key], 'Direct work exceeds attendance')
    machine_batch_minutes = defaultdict(int)
    for key, intervals in machine_intervals.items():
        no_overlap([(s, e) for s, e, b in intervals], f'machine {key}')
        require(len({b for s, e, b in intervals}) <= 2, 'Machine lot capacity exceeded')
        require(sum(e-s for s, e, b in intervals) <= 480, 'Machine hours exceed shift')
        for s, e, b in intervals:
            machine_batch_minutes[b] += e - s
    for day in working:
        # Whole-day upper bound includes finish-day occupancy until completion.
        held = sum(b['start_qty'] for b in batches.values()
                   if b['start_date'] <= day <= b['finish_date'])
        require(held <= 8000, f'Holding capacity exceeded {day}')
    for batch in batches.values():
        same(working.index(batch['finish_date']) - working.index(batch['start_date']), 4,
             'Three working days waiting between form and finish')
        labor_cost = sum(Decimal(employees[r['employee_id']]['base_salary_vnd']) *
                         int(r['minutes']) / data['calendar']['scheduled_minutes']
                         for r in labor if r['batch_id'] == batch['batch_id'])
        same(rounded(labor_cost), batch['labor_cost_vnd'], 'Labor source cost')
    for source in data['overhead_sources']:
        job_batches = [b for b in batches.values() if b['job_id'] == source['job_id']]
        measured = sum(machine_batch_minutes[b['batch_id']] for b in job_batches)
        same(measured, source['machine_minutes'], 'Actual machine basis')
        for b in job_batches:
            same(rounded(Decimal(source['amount_vnd']) * machine_batch_minutes[b['batch_id']] / measured),
                 b['overhead_cost_vnd'], 'Overhead allocation')
        same(sum(b['overhead_cost_vnd'] for b in job_batches), source['amount_vnd'], 'Overhead conservation')
    qc = {q['batch_id']: q for q in data['quality_results']}
    disposals = {x['batch_id']: x for x in data['disposals']}
    for b in batches.values():
        q, disposal = qc[b['batch_id']], disposals[b['batch_id']]
        same(q['inspected_qty'], b['start_qty'], 'Inspected quantity')
        same(q['good_qty'] + q['reject_qty'] + q['hold_qty'], b['start_qty'], 'QC reconciliation')
        same(q['good_qty'], b['good_qty'], 'QC good')
        same(sum(q['reject_reasons'].values()), q['reject_qty'], 'Reject reasons')
        same(disposal['qty'], q['reject_qty'], 'Disposed quantity')
        require(disposal['executed_date'] >= q['date'] and disposal['status'] == 'executed_demo',
                'Disposal not actually executed')
        require(disposal['approved_by'] != disposal['prepared_by'], 'Self disposal approval')
    purchase_qc = {q['stock_event_id']: q for q in data['purchase_quality']}
    for row in data['stock_events']:
        if row['kind'] == 'purchase_receive':
            q = purchase_qc[row['event_id']]
            same(q['lot_id'], row['lot_id'], 'Purchase QC source lot')
            same(q['good_qty_kg'], row['qty'], 'Purchase usable receipt')
            same(q['good_qty_kg'] + q['reject_qty_kg'] + q['hold_qty_kg'],
                 q['inspected_qty_kg'], 'Purchase QC split')
            same(q['confirmed_date'], row['date'], 'Purchase QC date')
    unique(data['stock_events'], 'event_id')
    unique(data['opening_inventory'], 'lot_id')
    quantity, value, lots = defaultdict(Decimal), defaultdict(Decimal), defaultdict(Decimal)
    material_cost = defaultdict(int)
    production_value = defaultdict(int)
    shipment_value = defaultdict(int)
    shipment_qty = defaultdict(int)
    purchase_received = defaultdict(int)
    for row in data['opening_inventory']:
        quantity[row['item_id']] += row['qty']
        value[row['item_id']] += row['value_vnd']
        lots[row['item_id'], row['lot_id']] += row['qty']
    previous_day = data['metadata']['opening_at'][:10]
    for row in data['stock_events']:
        item, qty, cost = row['item_id'], Decimal(str(row['qty'])), row['value_vnd']
        require(row['date'] >= previous_day, 'Stock event dates not ordered')
        previous_day = row['date']
        require(qty > 0 and cost >= 0, 'Invalid stock quantity/value')
        require(row['actor_id'] in employees, 'Unknown stock actor')
        if item in {v['variant_id'] for v in data['variants']}:
            require(qty == int(qty), 'Fractional piece')
        else:
            require(qty == qty.quantize(Decimal('0.001')), 'Invalid material precision')
        if row['kind'] in ('purchase_receive', 'production_receive'):
            if row['kind'] == 'production_receive':
                b = batches[row['source_id']]
                same(row['qty'], qc[b['batch_id']]['good_qty'], 'FG quantity matches QC')
                require(row['date'] >= qc[b['batch_id']]['date'], 'FG before QC')
                same(cost, b['total_cost_vnd'], 'FG value matches source')
                production_value[b['batch_id']] += cost
            else:
                purchase_received[row['source_id']] += row['qty']
            quantity[item] += qty
            value[item] += cost
            lots[item, row['lot_id']] += qty
        elif row['kind'] in ('production_issue', 'shipment'):
            require(quantity[item] >= qty and lots[item, row['lot_id']] >= qty, 'Negative stock/lot')
            same(cost, int(value[item]) if quantity[item] == qty else
                 rounded(value[item] * qty / quantity[item]), 'Moving average issue value')
            quantity[item] -= qty
            value[item] -= cost
            lots[item, row['lot_id']] -= qty
            if row['kind'] == 'production_issue':
                material_cost[row['source_id']] += cost
            else:
                shipment_value[row['source_id']] += cost
                shipment_qty[row['source_id']] += row['qty']
        else:
            raise ValueError('Unknown stock event type')
        require(lots['CEM', 'OPEN-CEM'] >= 300, 'Reserved other cement consumed')
    bom = {b['bom_id']: b for b in data['bom']}
    for batch in batches.values():
        issued = defaultdict(Decimal)
        for row in data['stock_events']:
            if row['kind'] == 'production_issue' and row['source_id'] == batch['batch_id']:
                issued[row['item_id']] += Decimal(str(row['qty']))
        same(dict(issued), bom[batch['bom_id']]['inputs'], 'BOM actual issued inputs')
        same(material_cost[batch['batch_id']], batch['material_cost_vnd'], 'Material source cost')
        same(batch['total_cost_vnd'], material_cost[batch['batch_id']] + batch['labor_cost_vnd'] +
             batch['overhead_cost_vnd'], 'Batch cost reconciliation')
        same(production_value[batch['batch_id']], batch['total_cost_vnd'], 'Single FG entry')
    unique(data['receipts'], 'receipt_id')
    unique(data['sales'], 'sale_id')
    unique(data['allocations'], 'allocation_id')
    receipts = {r['receipt_id']: r for r in data['receipts']}
    sales = {s['sale_id']: s for s in data['sales']}
    orders = {o['order_id']: o for o in data['orders']}
    for order in orders.values():
        same(rounded(Decimal(order['list_price_vnd']) * (100-order['discount_pct']) / 100),
             order['net_price_vnd'], 'Discount once')
        same(order['qty'] * order['net_price_vnd'], order['total_vnd'], 'Order value')
    by_receipt, by_sale = defaultdict(int), defaultdict(int)
    for a in data['allocations']:
        r, s = receipts[a['receipt_id']], sales[a['sale_id']]
        require(a['amount_vnd'] > 0 and r['order_id'] == s['order_id'], 'Allocation wrong source/customer')
        require(a['confirmed_date'] >= r['date'] and a['confirmed_date'] >= s['date'],
                'Allocation before receipt or sale')
        by_receipt[r['receipt_id']] += a['amount_vnd']
        by_sale[s['sale_id']] += a['amount_vnd']
        require(by_receipt[r['receipt_id']] <= r['amount_vnd'], 'Receipt overallocated')
        require(by_sale[s['sale_id']] <= s['revenue_vnd'], 'Debt overallocated')
    for s in sales.values():
        same(s['qty'], shipment_qty[s['shipment_id']], 'Sale accepted/shipped quantity')
        same(s['cogs_vnd'], shipment_value[s['shipment_id']], 'Shipment/sale cost')
        same(s['revenue_vnd'], s['qty'] * orders[s['order_id']]['net_price_vnd'], 'Sale source price')
        same(s['due_date'], str(date.fromisoformat(s['date'])+timedelta(days=15)), 'Due date')
    for r in receipts.values():
        require(r['payer_id'] == orders[r['order_id']]['payer_id'], 'Wrong payer')
    for order in orders.values():
        same(sum(s['qty'] for s in sales.values() if s['order_id'] == order['order_id']),
             order['qty'], 'Fulfilled order')
    unique(data['payroll'], 'employee_id')
    same(len(data['payroll']), 50, 'Payroll lines')
    for row in data['payroll']:
        p = employees[row['employee_id']]
        computed = rounded(Decimal(p['base_salary_vnd']) * paid[p['employee_id']] /
                           data['calendar']['scheduled_minutes'])
        same(row['time_salary_vnd'], computed, 'Salary source')
        same(row['allowance_vnd'], int(p['fixed_allowance_vnd']), 'Allowance source')
        income = computed + int(p['fixed_allowance_vnd'])
        same(row['income_before_mandatory_deductions_vnd'], income, 'Income')
        same(row['advance_applied_vnd'] + row['paid_final_demo_vnd'] +
             row['remaining_before_mandatory_deductions_vnd'], income, 'Salary cash reconciliation')
    ceo = next(p for p in data['payroll'] if p['employee_id'] == 'E001')
    same(ceo['salary_approval_status'], 'pending_independent_review', 'CEO own payroll status')
    for row in data['payroll']:
        eid = row['employee_id']
        advance_cash = sum(p['amount_vnd'] for p in data['cash_disbursements']
                           if p['kind'] == 'salary_advance' and p['source_id'] == eid)
        salary_cash = sum(p['amount_vnd'] for p in data['cash_disbursements']
                          if p['kind'] == 'salary' and p['source_id'] == 'PAY-SEP-V1:' + eid)
        same(advance_cash, row['advance_applied_vnd'], 'Advance actual payment')
        same(salary_cash, row['paid_final_demo_vnd'], 'Salary actual payment')
    unique(data['cash_disbursements'], 'payment_id')
    bank = data['opening_bank_vnd']
    bank_events = [(r['date'], r['amount_vnd']) for r in receipts.values()]
    bank_events += [(r['date'], -r['amount_vnd']) for r in data['cash_disbursements']]
    for day, amount in sorted(bank_events):
        bank += amount
        require(bank >= 0, 'Bank overdraft')
    for p in data['cash_disbursements']:
        require(p['approved_by'] != p['prepared_by'] and p['confirmed_by'] != p['approved_by'],
                'Payment roles not separated')
    supplier_debt = 0
    for po in data['purchases']:
        same(purchase_received[po['purchase_id']], po['qty_bags'] * po['kg_per_bag'], 'PO received')
        same(po['total_vnd'], po['qty_bags'] * po['unit_price_bag_vnd'], 'PO total')
        paid_po = sum(p['amount_vnd'] for p in data['cash_disbursements']
                      if p['source_id'] == po['obligation_id'])
        same(paid_po, po['payment_vnd'], 'PO payment source')
        supplier_debt += po['total_vnd'] - paid_po
    e = data['expected']
    calculated = dict(tile_good_end_qty=int(quantity['FP04-GREY-D1']),
        tile_inventory_value_vnd=int(value['FP04-GREY-D1']),
        terrazzo_good_end_qty=int(quantity['G01-GREY-D1']),
        terrazzo_inventory_value_vnd=int(value['G01-GREY-D1']),
        cement_end_qty=int(quantity['CEM']), cement_reserved_qty=300,
        cement_available_qty=int(quantity['CEM'])-300, supplier_payable_vnd=supplier_debt,
        overhead_unpaid_vnd=sum(s['amount_vnd'] for s in data['overhead_sources']),
        bank_end_vnd=bank, customer_receivable_vnd=sum(s['revenue_vnd']-by_sale[s['sale_id']] for s in sales.values()),
        customer_unallocated_receipts_vnd=sum(r['amount_vnd']-by_receipt[r['receipt_id']] for r in receipts.values()),
        total_income_before_mandatory_deductions_vnd=sum(p['income_before_mandatory_deductions_vnd'] for p in data['payroll']),
        remaining_income_before_mandatory_deductions_vnd=sum(p['remaining_before_mandatory_deductions_vnd'] for p in data['payroll']),
        tile_labor_minutes=job_minutes['MO-N-001'], terrazzo_labor_minutes=job_minutes['MO-T-001'])
    for prefix, order in [('tile','SO-N-001'), ('terrazzo','SO-T-001')]:
        revenue = sum(s['revenue_vnd'] for s in sales.values() if s['order_id']==order)
        cogs = sum(s['cogs_vnd'] for s in sales.values() if s['order_id']==order)
        calculated.update({prefix+'_revenue_vnd':revenue, prefix+'_cogs_vnd':cogs,
                           prefix+'_gross_margin_vnd':revenue-cogs})
    pool = sum(int(employees[f'E{i:03}']['base_salary_vnd']) for i in range(16,23))
    direct_cost = sum(b['labor_cost_vnd'] for b in batches.values())
    calculated.update(seven_workers_salary_pool_vnd=pool, direct_labor_cost_vnd=direct_cost,
                      seven_workers_other_cost_vnd=pool-direct_cost)
    same(set(calculated), set(e), 'All expected outputs verified')
    for key, result in calculated.items():
        same(result, e[key], key)
    for item in ('SAND','COAT','STONE','PIGMENT','WATER'):
        same(quantity[item], 0, 'Remaining material '+item)
        same(value[item], 0, 'Remaining value '+item)
    source_value = (sum(r['value_vnd'] for r in data['opening_inventory']) +
                    sum(p['total_vnd'] for p in data['purchases']) + direct_cost +
                    sum(o['amount_vnd'] for o in data['overhead_sources']))
    same(source_value, sum(value.values()) + sum(s['cogs_vnd'] for s in sales.values()),
         'Total value conservation')
    same(sum(actual_work[f'E{i:03}',d] for i in range(16,23) for d in working)-sum(direct.values()),
         data['labor_other_allocation']['seven_worker_minutes'], 'Other labor minutes')
    cases_data = json.loads((folder / 'scenario-cases.json').read_text())
    cases = cases_data['cases']
    unique(cases, 'case_id')
    same({c['case_id'] for c in cases}, {f'X{i:02}' for i in range(1,25)}, 'Exception case coverage')
    for c in cases:
        require(bool(c['reset_to']) and bool(c['action']) and bool(c['inputs']) and bool(c['expected']),
                'Incomplete exception case')
    case_map = {c['case_id']: c for c in cases}
    for cid in ('X01','X02','X04','X05','X07','X08','X09','X10','X11','X12','X13','X16'):
        inp, exp = case_map[cid]['inputs'], case_map[cid]['expected']
        if cid == 'X01':
            same(inp['required_deposit_vnd']-inp['received_deposit_vnd'], exp['missing_deposit_vnd'], cid)
        elif cid == 'X02':
            same(inp['good_qty']+inp['reject_qty'], inp['start_qty'], cid+' quantity')
            same(inp['good_qty']-inp['order_qty'], exp['remaining_custom_good_qty'], cid+' remaining')
            same(inp['order_qty']*inp['price_vnd'], exp['revenue_vnd'], cid+' revenue')
            same(exp['revenue_vnd']-inp['deposit_vnd'], exp['receivable_vnd'], cid+' debt')
        elif cid == 'X04':
            same(inp['order_qty']-inp['started_qty'], exp['not_started_qty'], cid+' started')
            same(inp['order_qty']-inp['accepted_delivery_qty'], exp['not_delivered_qty'], cid+' delivery')
        elif cid == 'X05':
            usable = inp['good_qty']-inp['locked_qty']
            reserved = inp['order_reserved_qty']-inp['locked_reserved_qty']
            same(usable, exp['usable_qty'], cid+' usable')
            same(reserved, exp['valid_reserved_qty'], cid+' reserved')
            same(usable-reserved, exp['available_qty'], cid+' available')
            same(inp['locked_reserved_qty'], exp['order_shortfall_qty'], cid+' shortage')
        elif cid == 'X07':
            same(inp['good_qty']+inp['returned_qty'], exp['physical_qty'], cid+' physical')
            same(inp['good_qty'], exp['usable_qty'], cid+' usable')
        elif cid == 'X08':
            refund = inp['returned_qty']*inp['sale_unit_price_vnd']
            cost_return = inp['returned_qty']*inp['original_unit_cogs_vnd']
            same(inp['base_tile_revenue_vnd']-refund, exp['tile_revenue_vnd'], cid+' revenue')
            same(inp['base_tile_cogs_vnd']-cost_return, exp['tile_cogs_vnd'], cid+' cogs')
            same(exp['tile_revenue_vnd']-exp['tile_cogs_vnd'], exp['tile_gross_margin_vnd'], cid+' margin')
            same(inp['base_tile_qty']+inp['returned_qty'], exp['tile_inventory_qty'], cid+' quantity')
            same(exp['tile_inventory_qty']*inp['original_unit_cogs_vnd'], exp['tile_inventory_value_vnd'], cid+' value')
            same(refund, exp['refund_due_vnd_before_payment'], cid+' refund')
            same(inp['base_bank_vnd']-refund, exp['bank_after_refund_vnd'], cid+' bank')
        elif cid == 'X09':
            remaining = inp['original_shipment_qty']-inp['prior_return_qty']
            same(remaining, exp['remaining_returnable_qty'], cid+' remaining')
            same(inp['new_return_qty']-remaining, exp['excess_qty'], cid+' excess')
        elif cid == 'X10':
            extra = rounded(Decimal(inp['base_salary_vnd'])*inp['changed_minutes']/inp['scheduled_minutes'])
            same(extra, exp['extra_income_vnd'], cid+' extra')
            same(inp['old_income_vnd']+extra, exp['new_income_vnd'], cid+' income')
            same(exp['new_income_vnd']-inp['already_paid_vnd'], exp['extra_remaining_before_mandatory_deductions_vnd'], cid+' remaining')
            same(inp['leave_remaining_minutes']-inp['changed_minutes'], exp['leave_remaining_minutes'], cid+' leave')
        elif cid == 'X11':
            physical = inp['opening_cement_qty']+inp['received_qty']
            usable = physical-inp['reject_qty']
            available = usable-inp['reserved_other_qty']
            same(physical, exp['physical_cement_qty'], cid+' physical')
            same(usable, exp['usable_cement_qty'], cid+' usable')
            same(available, exp['available_for_n_qty'], cid+' available')
            same(inp['required_for_n_qty']-available, exp['n_shortfall_qty'], cid+' shortage')
        elif cid == 'X12':
            same(inp['received_usable_for_n_if_late_qty']//inp['cement_per_full_lot_qty'], exp['max_full_lots_by_cement_only'], cid)
        elif cid == 'X13':
            same(inp['remaining_qualified_workers']*inp['direct_minutes_each'], exp['actual_team_direct_minutes'], cid)
        elif cid == 'X16':
            remaining = inp['available_qty']-inp['first_request_qty']
            same(remaining, exp['available_after_first_qty'], cid+' remaining')
            same(inp['second_request_qty']-remaining, exp['second_shortfall_qty'], cid+' shortage')
    return dict(checks=checks, employees=len(people), attendance=len(attendance),
                labor_intervals=len(labor), stock_events=len(data['stock_events']), exception_cases=len(cases),
                bank_end_vnd=bank, inventory_value_vnd=int(sum(value.values())),
                revenue_vnd=sum(s['revenue_vnd'] for s in sales.values()),
                cogs_vnd=sum(s['cogs_vnd'] for s in sales.values()))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path,
                        default=Path(__file__).resolve().parents[1]/'docs/demo-data')
    args = parser.parse_args()
    try:
        result = validate(args.directory)
    except (ValueError, KeyError, IndexError, ArithmeticError) as exc:
        print(f'DATA INVALID: {exc}', file=sys.stderr)
        return 1
    print('BA fixture validation passed; application not tested.')
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0

if __name__ == '__main__':
    sys.exit(main())
