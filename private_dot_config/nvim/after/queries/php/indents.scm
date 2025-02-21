;; extends

[
  ; prevent double indent for `return new class ...`
  (return_statement
    (object_creation_expression))
  ; prevent double indent for `return function() { ... }`
  (return_statement
    (anonymous_function))
] @indent.dedent

[
  (member_call_expression)
  (member_access_expression)
  (conditional_expression)
] @indent.begin
