;;; greek-qwertz --- Exported from Org Mode
;;; 2026-03-13 10:14:14 pm CET

;;; greek-qwertz.el --- Greek input method on German QWERTZ with symbols unchanged -*- lexical-binding: t; -*-

(require 'quail)

(quail-define-package
 "greek-qwertz" "Greek" "GR-QWERTZ" nil
 "Greek letters mapped to a German QWERTZ keyboard. All symbols and punctuation follow German layout 1:1."
 nil t t t t nil nil nil nil nil t)

(quail-define-rules
 ;; Number row and punctuation as on German keyboard
 ("1" ?1) ("2" ?2) ("3" ?3) ("4" ?4) ("5" ?5)
 ("6" ?6) ("7" ?7) ("8" ?8) ("9" ?9) ("0" ?0)
 ("ß" ?ß) ("´" ?´) ("^" ?^) ("+" ?+) ("#" ?#)
 ("<" ?<) (">" ?>) ("-" ?-) ("_" ?_) ("=" ?=)
 ("§" ?§) ("!" ?!) ("\"" ?\") ("$" ?$) ("%" ?%)
 ("&" ?&) ("/" ?/) ("(" ?\() (")" ?\)) ("?" ??)
 ("\\" ?\\) ("[" ?\[) ("]" ?\]) ("{" ?{) ("}" ?})
 (";" ?-) (":" ?:)
 ("«" ?<) ("»" ?>)

 ;; QWERTZ: letters mapped to Greek
 ("q" ?θ) ("Q" ?Θ)
 ("w" ?ω) ("W" ?Ω)
 ("e" ?ε) ("E" ?Ε)
 ("r" ?ρ) ("R" ?Ρ)
 ("t" ?τ) ("T" ?Τ)
 ("z" ?ζ) ("Z" ?Ζ)  ;; Z key = ζ
 ("u" ?υ) ("U" ?Υ)
 ("i" ?ι) ("I" ?Ι)
 ("o" ?ο) ("O" ?Ο)
 ("p" ?π) ("P" ?Π)

 ("a" ?α) ("A" ?Α)
 ("s" ?σ) ("S" ?Σ)
 ("d" ?δ) ("D" ?Δ)
 ("f" ?φ) ("F" ?Φ)
 ("g" ?γ) ("G" ?Γ)
 ("h" ?η) ("H" ?Η)
 ("j" ?ξ) ("J" ?Ξ)
 ("k" ?κ) ("K" ?Κ)
 ("l" ?λ) ("L" ?Λ)

 ("y" ?υ) ("Y" ?Υ)  ;; Y key = υ (swapped with Z)
 ("x" ?χ) ("X" ?Χ)
 ("c" ?ψ) ("C" ?Ψ)
 ("v" ?ν) ("V" ?Ν)
 ("b" ?β) ("B" ?Β)
 ("n" ?η) ("N" ?Η)
 ("m" ?μ) ("M" ?Μ)
)


(provide 'greek-qwertz)
;;; 020_greek-qwertz.el ends here
