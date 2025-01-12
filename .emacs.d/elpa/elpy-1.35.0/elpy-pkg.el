;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "elpy" "1.35.0"
  "Emacs Python Development Environment."
  '((company               "0.9.2")
    (emacs                 "24.4")
    (highlight-indentation "0.5.0")
    (pyvenv                "1.3")
    (yasnippet             "0.8.0")
    (s                     "1.11.0"))
  :url "https://github.com/jorgenschaefer/elpy"
  :commit "4666c16ef362d4f99053bbc0856d8c65121e1825"
  :revdesc "1.35.0-0-g4666c16ef362"
  :keywords '("python" "ide" "languages" "tools")
  :authors '(("Jorgen Schaefer" . "contact@jorgenschaefer.de")
             ("Gaby Launay" . "gaby.launay@protonmail.com"))
  :maintainers '(("Jorgen Schaefer" . "contact@jorgenschaefer.de")
                 ("Gaby Launay" . "gaby.launay@protonmail.com")))
