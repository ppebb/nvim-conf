;; extends

(
 ((identifier) @constant.builtin
  (#any-of? @constant.builtin "Some" "None" "Ok" "Err")
  (#set! "priority" 128))
)
