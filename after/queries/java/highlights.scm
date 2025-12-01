;; extends

(
 ((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\\d_]+$")
 (#set! "priority" 128))
)
