; https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/json/highlights.scm minus conceal queries

[
  (true)
  (false)
] @boolean

(null) @constant.builtin

(number) @number

(pair
  key: (string) @property)

(pair
  value: (string) @string)

(array
  (string) @string)

[
  ","
  ":"
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(escape_sequence) @string.escape
