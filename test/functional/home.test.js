import faker from "faker";
import puppeteer from "puppeteer";
import "@babel/polyfill";

let page;
let browser;
const width = 1920;
const height = 1080;

const testUserEmail = process.env.TEST_USER_EMAIL;
const testUserPass = process.env.TEST_USER_PASS;

const APP = "http://localhost:5000/";

async function setupBrowser() {
  browser = await puppeteer.launch({
    // headless: false,
    // // slowMo: 40,
    // args: [`--window-size=${width},${height}`]
  });
  page = await browser.newPage();
  await page.setViewport({ width, height });
}

async function getInputValue(selector) {
  return await page.evaluate(selector => document.querySelector(selector).value, selector);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

beforeAll(async () => {
  await setupBrowser();
});
afterAll(() => {
  if (browser != null) {
    browser.close();
  }
});

describe("Home Page", () => {
  test("successful login and logout", async () => {
    await page.goto(APP);
    await page.waitForSelector("#home-container");

    await page.type("#email-input", testUserEmail);
    await page.type("#pass-input", testUserPass);

    await page.click("#login-submit-button");
    await page.waitForSelector("#log-out-button");

    // TODO: Check displayed userdata here

    await page.click("#log-out-button");
    await page.waitForSelector("#home-container");
  }, 16000);

  test("error when invalid email", async () => {
    await page.goto(APP);
    await page.waitForSelector("#home-container");

    await page.type("#email-input", faker.random.alphaNumeric(10));
    await page.type("#pass-input", faker.random.alphaNumeric(5));

    await page.click("#login-submit-button");

    await page.waitForSelector("#hint-invalidemail");
  }, 16000);

  test("clear inputs when cancel clicked", async () => {
    await page.goto(APP);
    await page.waitForSelector("#home-container");

    await page.type("#email-input", faker.internet.userName());
    await page.type("#pass-input", faker.random.alphaNumeric(5));

    expect(await getInputValue("#email-input")).not.toBe("");
    expect(await getInputValue("#pass-input")).not.toBe("");

    await page.click("#cancel-button");

    await sleep(100);

    expect(await getInputValue("#email-input")).toBe("");
    expect(await getInputValue("#pass-input")).toBe("");
  }, 16000);

  test("error when email does not exist", async () => {
    await page.goto(APP);
    await page.waitForSelector("#home-container");

    await page.type("#email-input", faker.internet.exampleEmail("spencer", "cornish"));
    await page.type("#pass-input", faker.random.alphaNumeric(8));

    await page.click("#login-submit-button");

    await page.waitForSelector("#hint-emailnotfound");
  }, 16000);

  test("error when incorrect password", async () => {
    await page.goto(APP);
    await page.waitForSelector("#home-container");

    await page.type("#email-input", "spenca2015@gmail.com");
    await page.type("#pass-input", faker.random.alphaNumeric(9));

    await page.click("#login-submit-button");

    await page.waitForSelector("#hint-invalidpassword");
  }, 16000);
});
