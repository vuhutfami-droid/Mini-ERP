import asyncio, json, time, os, shutil
from pathlib import Path
from playwright.async_api import async_playwright

ROOT = Path(__file__).resolve().parents[1]
creds = json.loads((ROOT / ".runtime/test-credentials.json").read_text())


async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch(
            executable_path=os.getenv("ERP_BROWSER_EXECUTABLE") or shutil.which("chromium"),
            headless=True,
            args=["--no-sandbox"],
        )
        results = []
        for count in (5, 10):
            pages = []
            for i in range(count):
                role = ["giamdoc", "kho", "sanxuat", "taichinh", "quantri"][i % 5]
                ctx = await browser.new_context()
                page = await ctx.new_page()
                await page.goto("http://127.0.0.1:8001/dang-nhap/")
                await page.locator("[name=username]").fill(role)
                await page.locator("[name=password]").fill(creds[role]["mat_khau"])
                await page.get_by_role("button", name="Đăng nhập vào hệ thống →").click()
                await page.wait_for_url("http://127.0.0.1:8001/")
                pages.append((role, ctx, page))

            async def measure(pair):
                role, ctx, page = pair
                samples = []
                for _ in range(3):
                    start = time.perf_counter()
                    r = await page.goto(
                        "http://127.0.0.1:8001/"
                        + ("" if role == "quantri" else "danh-muc/doi-tac/"),
                        wait_until="load",
                    )
                    assert r.status == 200
                    samples.append((time.perf_counter() - start) * 1000)
                return samples

            samples = sum(await asyncio.gather(*(measure(x) for x in pages)), [])
            p95 = sorted(samples)[int(len(samples) * 0.95) - 1]
            results.append(
                {
                    "phien": count,
                    "so_mau": len(samples),
                    "p95_tai_trang_ms": round(p95, 2),
                    "max_ms": round(max(samples), 2),
                    "dat_2s": p95 < 2000,
                }
            )
            for _, ctx, _ in pages:
                await ctx.close()
        await browser.close()
    report = json.loads((ROOT / "docs/implementation/performance.json").read_text())
    report["trinh_duyet"] = {
        "pham_vi": "Chromium cùng máy, HTTP localhost, đến sự kiện load; không gồm mạng Internet/hosting thật",
        "ket_qua": results,
    }
    (ROOT / "docs/implementation/performance.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n"
    )
    print(json.dumps(results, ensure_ascii=False))
    assert all(x["dat_2s"] for x in results)


asyncio.run(main())
