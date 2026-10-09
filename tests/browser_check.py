import json, sys, os, re, time, shutil, faulthandler
faulthandler.dump_traceback_later(45)
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from playwright.sync_api import sync_playwright

creds = json.loads((ROOT / ".runtime/credentials.json").read_text())
with sync_playwright() as p:
    print("browser: launch",flush=True)
    browser = p.chromium.launch(
        executable_path=os.getenv("ERP_BROWSER_EXECUTABLE") or shutil.which("chromium"),
        headless=True,
        args=["--no-sandbox"],
    )
    ctx = browser.new_context(viewport={"width": 1440, "height": 1000})
    page = ctx.new_page()
    errors = []
    page.on("pageerror", lambda e: errors.append(str(e)))

    def login(role="giamdoc"):
        page.goto("http://127.0.0.1:8000/dang-nhap/")
        page.get_by_label("Tên đăng nhập").fill(role)
        page.get_by_label("Mật khẩu").fill(creds[role]["mat_khau"])
        page.get_by_role("button", name="Đăng nhập vào hệ thống →", exact=True).click()
        page.wait_for_url("http://127.0.0.1:8000/")

    login()
    print("browser: logged in",flush=True)
    page.screenshot(path=str(ROOT / "docs/implementation/foundation-desktop.png"), full_page=True)
    # Verify every list and form is rendered rather than relying on a successful homepage.
    from foundation.catalog import REGISTRY

    for slug in REGISTRY:
        response = page.goto(f"http://127.0.0.1:8000/danh-muc/{slug}/")
        assert response.status == 200, (slug, response.status)
        response = page.goto(f"http://127.0.0.1:8000/danh-muc/{slug}/them/")
        assert response.status == 200, (slug, response.status)
    page.goto("http://127.0.0.1:8000/danh-muc/nhan-su/")
    page.locator("tbody a").first.click()
    assert page.locator("[name=ngay_vao_lam]").input_value() == "2026-09-01"
    page.goto("http://127.0.0.1:8000/danh-muc/doi-tac/them/")
    print("browser: catalogs/date checked",flush=True)
    code = "UI-" + str(int(time.time()))
    page.locator("[name=ma_nghiep_vu]").fill(code)
    page.locator("[name=ten]").fill("Đối tác kiểm bằng trình duyệt")
    page.locator("[name=cac_vai_tro]").select_option("khach_hang")
    page.locator("[name=dang_su_dung]").check()
    page.wait_for_function(
        "() => document.querySelector('.save-state').textContent.includes('Đã lưu nháp')"
    )
    draft_url = page.url
    page.reload()
    page.wait_for_function(
        "() => document.querySelector('[name=ten]').value.includes('Đối tác kiểm')"
    )
    ctx.set_offline(True)
    page.locator("[name=ten]").fill("Đối tác kiểm trình duyệt đã sửa")
    page.wait_for_function(
        "() => document.querySelector('.save-state').textContent.includes('Mất mạng')"
    )
    ctx.set_offline(False)
    page.wait_for_function(
        "() => document.querySelector('.save-state').textContent.includes('Đã lưu nháp')"
    )
    page.get_by_role("button", name="Lưu thông tin", exact=True).click()
    page.wait_for_url("**/danh-muc/doi-tac/")
    page.locator("[name=q]").fill(code)
    page.get_by_role("button", name="Tìm", exact=True).click()
    page.get_by_text("Đối tác kiểm trình duyệt đã sửa", exact=True).wait_for()
    print("browser: source saved",flush=True)
    # Two tabs based on the same stored version: the second must receive a conflict.
    link = page.locator("tbody a").first
    href = link.get_attribute("href")
    page.goto("http://127.0.0.1:8000" + href)
    other = ctx.new_page()
    other.goto(page.url)
    page.locator("[name=ten]").fill("Bản cập nhật tab một")
    time.sleep(2)
    page.get_by_role("button", name="Lưu thông tin", exact=True).click()
    page.wait_for_url("**/danh-muc/doi-tac/")
    other.locator("[name=ten]").fill("Bản cũ tab hai")
    time.sleep(2)
    with other.expect_response(
        lambda r: "/danh-muc/doi-tac/" in r.url and r.request.method == "POST"
    ) as resp:
        other.get_by_role("button", name="Lưu thông tin", exact=True).click()
    assert resp.value.status == 409
    other.close()
    print("browser: stale version checked",flush=True)
    # Responsive browser; no page-level horizontal scrolling at a phone viewport.
    mobile = browser.new_context(
        viewport={"width": 390, "height": 844}, is_mobile=True, has_touch=True
    )
    mobile.add_cookies(ctx.cookies())
    mp = mobile.new_page()
    mp.goto("http://127.0.0.1:8000/")
    assert mp.evaluate("() => document.documentElement.scrollWidth <= window.innerWidth")
    mp.screenshot(path=str(ROOT / "docs/implementation/foundation-mobile.png"), full_page=True)
    page.goto("http://127.0.0.1:8000/")
    page.get_by_role("button", name="Đăng xuất", exact=True).click()
    page.wait_for_url("**/dang-nhap/")
    login("quantri")
    r = page.goto("http://127.0.0.1:8000/danh-muc/nhan-su/")
    assert r.status == 403
    assert not errors, errors
    print("browser: checks complete; close",flush=True)
    browser.close()
print(
    "PASS browser: 17 catalogs/forms, login/logout, server draft reload, offline/reconnect, real create/search, stale tab 409, denied role, desktop/mobile 390px."
)
