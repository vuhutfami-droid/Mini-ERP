'use strict';
for (const a of document.querySelectorAll('nav a')) if (a.pathname===location.pathname) a.classList.add('active');
const form=document.querySelector('form[data-kind]');
if(form){
 let dirty=false,version=0,saving=false,timer,submitted=false;
 const state=form.querySelector('.save-state'),csrf=form.querySelector('[name=csrfmiddlewaretoken]').value;
 const fields=()=>{const o={};for(const el of form.elements){if(!el.name||['csrfmiddlewaretoken','request_key','version','draft_id','form_workspace'].includes(el.name))continue;o[el.name]=el.type==='checkbox'?el.checked:el.value;}return o;};
 const save=async()=>{if(saving||submitted||!dirty)return; if(!navigator.onLine){state.textContent='Mất mạng · còn dữ liệu chưa lưu';return;}
  saving=true;const snapshot=JSON.stringify(fields());state.textContent='Đang lưu nháp…';
  try{const r=await fetch('/nhap/',{method:'POST',headers:{'Content-Type':'application/json','X-CSRFToken':csrf,'X-Requested-With':'XMLHttpRequest'},body:JSON.stringify({id:form.dataset.draft,kind:form.dataset.kind,workspace:form.elements.form_workspace.value,entity:form.dataset.entity,fields:JSON.parse(snapshot),version})});
   if(!r.ok)throw Error('Chưa lưu nháp · kiểm tra mạng, quyền hoặc tab khác');
   const data=await r.json();version=data.version;dirty=JSON.stringify(fields())!==snapshot;state.textContent=dirty?'Còn thay đổi chưa lưu':'Đã lưu nháp trên máy chủ';
   const url=new URL(location.href);url.searchParams.set('draft',form.dataset.draft);history.replaceState(null,'',url);if(dirty)timer=setTimeout(save,1200);
  }catch(e){state.textContent=e.message;}finally{saving=false;}
 };
 form.addEventListener('input',()=>{dirty=true;state.textContent='Chưa lưu thay đổi';clearTimeout(timer);timer=setTimeout(save,1500);});
 form.addEventListener('submit',e=>{if(saving){e.preventDefault();state.textContent='Đang lưu nháp, hãy chờ một chút rồi xác nhận.';return;}submitted=true;clearTimeout(timer);});
 addEventListener('beforeunload',e=>{if(dirty&&!submitted){e.preventDefault();e.returnValue='';}});
 addEventListener('online',save);addEventListener('offline',()=>{if(dirty)state.textContent='Mất mạng · chưa lưu';});
 if(new URL(location.href).searchParams.has('draft'))fetch('/nhap/'+form.dataset.draft+'/').then(r=>{if(!r.ok)throw Error();return r.json();}).then(data=>{for(const [k,v] of Object.entries(data.fields)){const el=form.elements.namedItem(k);if(!el)continue;if(el.type==='checkbox')el.checked=Boolean(v);else el.value=v??'';}version=data.version;state.textContent='Đã mở lại nháp của anh/chị';}).catch(()=>{state.textContent='Không thể mở nháp; kiểm tra quyền hoặc hạn lưu';});
}
for(const f of document.querySelectorAll('form:not([data-kind])'))f.addEventListener('submit',()=>{const b=f.querySelector('button[type=submit],button:not([type])');if(b)setTimeout(()=>{b.disabled=true;},0);});
const af=document.getElementById('apply-access');if(af)af.addEventListener('submit',e=>{const id=af.elements.decision.value.trim();if(!/^[0-9a-f-]{36}$/i.test(id)){e.preventDefault();return;}af.action=af.dataset.actionRoot+encodeURIComponent(id)+'/ap-dung/';});

if(document.querySelector('.account'))setInterval(async()=>{if(document.visibilityState!=='visible')return;try{const r=await fetch('/trang-thai/');if(r.ok){const d=await r.json();const el=document.querySelector('[data-waiting]');if(el)el.textContent=d.waiting;}}catch{}},20000);

const qcForm=document.querySelector('[data-qc-select]');if(qcForm)qcForm.elements.policy.addEventListener('change',()=>{const url=new URL(location.href);url.searchParams.set('policy',qcForm.elements.policy.value);location.href=url;});

const mobileCatalog=document.querySelector('.mobile-catalog');if(mobileCatalog)mobileCatalog.addEventListener('change',()=>{if(mobileCatalog.value)location.href=mobileCatalog.value;});
