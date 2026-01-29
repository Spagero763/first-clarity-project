;; Greeting Contract
;; Store personalized greetings on-chain

(define-map greetings principal (string-utf8 100))

(define-public (set-greeting (message (string-utf8 100)))
  (begin
    (map-set greetings tx-sender message)
    (ok message)
  )
)

(define-read-only (get-greeting (user principal))
  (default-to u"Hello, World!" (map-get? greetings user))
)
