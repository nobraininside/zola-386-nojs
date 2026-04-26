# Zola 386 NOJS

A lightweight, high-performance, and privacy-focused theme for [Zola](https://www.getzola.org/). Inspired by the 90s DOS aesthetic.

## Philosophy
* **Zero Dependencies:** No external JS libraries (no jQuery, no Analytics, no Disqus).
* **Maximum Speed:** Built for instant loading and minimal resource consumption.
* **Privacy First:** No tracking, no external scripts. 100% static.
* **Responsive:** Uses native CSS Flexbox for layout, avoiding bloated frameworks.

## Installation

1. Clone this repository into your Zola `themes/` folder:
   ```bash
   git submodule add https://github.com/nobraininside/zola-386 themes/zola-386


Enable the theme in your config.toml:
theme = "zola-386-nojs"


Configuration
Configure your config.toml to customize the site.
Menu
Define your navigation menu under [extra]:
[extra]
zola386_menu = [
  {path="", name="Home"},
  {path="categories", name="Categories"},
  {path="tags", name="Tags"},
  {path="about", name="About"},
]

Labels
Localize your site by setting the label_ variables in [extra]:
[extra]
label_tags = "Tags"
label_date = "Date"
label_reading = "Reading time"
# ... and so on

Contributing
This theme aims to remain minimal and fast. Contributions are welcome, provided they do not add external dependencies or bloat the CSS.
License
Released under the MIT License.