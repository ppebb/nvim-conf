;; Keywords ???
;; (modifier) @keyword
(this_expression) @keyword
;; (escape_sequence) @keyword

;; Types
(constructor_declaration name: (identifier) @type)

;; Variable
;; (variable_declaration (identifier) @variable)

;; Record
(with_expression
  (with_initializer_expression
    (simple_assignment_expression
      (identifier) @type)))

;; Class
(property_declaration
  type: (nullable_type) @type
  name: (identifier) @type)
(property_declaration
  type: (predefined_type) @type.builtin
  name: (identifier) @type)
(property_declaration
  type: (identifier) @type
  name: (identifier) @type)

;; Type
(generic_name (identifier) @type)
(type_parameter (identifier) @type)
(type_argument_list (identifier) @type)

;; Exception
;; (catch_declaration (identifier) @keyword (identifier) @keyword)
;; (catch_declaration (identifier) @keyword)

;; Switch
(switch_statement (identifier) @variable)
(switch_expression (identifier) @variable)

;; Lock statement
;; (lock_statement (identifier) @keyword)
