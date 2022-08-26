;; From MDeiml/tree-sitter-markdown
;; [
;;   (code_span)
;;   (link_title)
;; ] @text.literal


(fenced_code_block 
 (info_string ((language) @conceal (#set! conceal "")))
)

(fenced_code_block 
 (fenced_code_block_delimiter) @conceal (#set! conceal "`")
)


;; search for code blocks
;; for each
;;   search for lang
;;     set conceal (get_icon)

;; [
;;   (emphasis_delimiter)
;;   (code_span_delimiter)
;; ] @punctuation.delimiter

;; (emphasis) @text.emphasis
;;
;; (strong_emphasis) @text.strong
;;
;; [
;;   (link_destination)
;;   (uri_autolink)
;; ] @text.uri
;;
;; [
;;   (link_label)
;;   (link_text)
;;   (image_description)
;; ] @text.reference
;;
;; [
;;   (backslash_escape)
;;   (hard_line_break)
;; ] @string.escape
;;
;; ; "(" not part of query because of
;; ; https://github.com/nvim-treesitter/nvim-treesitter/issues/2206
;; ; TODO: Find better fix for this
;; (image ["!" "[" "]" "("] @punctuation.delimiter)
;; (inline_link ["[" "]" "("] @punctuation.delimiter)
;; (shortcut_link ["[" "]"] @punctuation.delimiter)
;;
;; ;; ([
;; ;;   (code_span_delimiter)
;; ;;   (emphasis_delimiter)
;; ;; ] @conceal
;; ;; (#set! conceal ""))
;;
;;
;; (fenced_code_block
;;   (fenced_code_block_delimiter) @conceal (#set! conceal "")
;; ) @code_block
;;
;; ;; (code_fence_content) @none
;;  
;;
;; ; Conceal inline links
;; (inline_link
;;   [
;;     "["
;;     "]"
;;     "("
;;    (link_destination)
;;     ")"
;; ] @conceal
;; (#set! conceal ""))
;;
;; ; Conceal image links
;; (image
;;   [
;;     "!"
;;     "["
;;     "]"
;;     "("
;;    (link_destination)
;;     ")"
;; ] @conceal
;;   (#set! conceal ""))
