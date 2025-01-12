;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "company-jedi" "0.4"
  "Company-mode completion back-end for Python JEDI."
  '((emacs     "24")
    (cl-lib    "0.5")
    (company   "0.8.11")
    (jedi-core "0.2.7"))
  :url "https://github.com/emacsorphanage/company-jedi"
  :commit "ad49407451c7f28fe137f9c8f3a7fc89e8693a1b"
  :revdesc "ad49407451c7"
  :authors '(("Boy" . "boyw165@gmail.com"))
  :maintainers '(("Boy" . "boyw165@gmail.com")))
