import { QuickstartPage } from './app.po';

describe('quickstart App', () => {
  let page: QuickstartPage;

  beforeEach(() => {
    page = new QuickstartPage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!!');
  });
});
