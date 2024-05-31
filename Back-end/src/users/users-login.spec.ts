import { test, expect } from '@playwright/test';

test('user login flow', async ({ browser }) => {
  const page = await browser.newPage();
  await page.goto('http://localhost:3000/login');

  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'password');
  await page.click('button[type="submit"]');

  await expect(page).toHaveURL('http://localhost:3000/dashboard');

  await page.close();
});
