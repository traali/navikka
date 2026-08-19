# Checklist: SEO & Semantics (Web)

To ensure Sakkoja maintains a premium, accessible, and performant presence on the Web, all web-related UI changes must satisfy this checklist.

## 1. Semantic HTML5
- [ ] **Heading Hierarchy**: Ensure exactly one `<h1>` per page. Use `<h2>` through `<h6>` in logical order.
- [ ] **Structural Elements**: Favor `<main>`, `<aside>`, `<nav>`, and `<section>` over generic `<div>` wrappers.
- [ ] **Interactive Elements**: Buttons must use `<button>` or a WAI-ARIA role with appropriate keyboard handling.
- [ ] **ARIA Labels**: All icon-only buttons (e.g., GPS toggle, Fishing toggle) must have a descriptive `aria-label`.

## 2. SEO Best Practices
- [ ] **Page Titles**: Descriptive and unique titles for every route.
- [ ] **Meta Descriptions**: Compelling snippets that summarize page content for search engines.
- [ ] **Alt Text**: All static images (markers, icons) that provide meaning must have descriptive `alt` attributes.
- [ ] **JSON-LD**: (Where applicable) Include structured data for marine locations or events.

## 3. Performance & Metadata
- [ ] **Favicons**: Verify that the Sakkoja anchor/logo favicon renders correctly in all browser tabs.
- [ ] **OpenGraph**: Verify social sharing preview metadata (title, image, description).
- [ ] **Robots.txt**: Ensure correct indexing rules are applied for the `sakkoja.pages.dev` domain.

---

> **Verification**: These checks should be part of the manual smoke test for every web deployment.
