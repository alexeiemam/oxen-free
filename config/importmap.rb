# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "swiper", to: "https://cdn.jsdelivr.net/npm/swiper@8.3.1/swiper.esm.js"
pin "dom7", to: "https://cdn.jsdelivr.net/npm/dom7@4.0.4/dom7.esm.js"
pin "ssr-window", to: "https://cdn.jsdelivr.net/npm/ssr-window@4.0.2/ssr-window.esm.js"
