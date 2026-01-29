;; Tip Jar Contract
;; Simple tipping mechanism

(define-constant CONTRACT-OWNER tx-sender)
(define-map tips principal uint)
(define-data-var total-tips uint u0)

(define-public (tip (amount uint))
  (begin
    (try! (stx-transfer? amount tx-sender CONTRACT-OWNER))
    (map-set tips tx-sender (+ amount (default-to u0 (map-get? tips tx-sender))))
    (var-set total-tips (+ (var-get total-tips) amount))
    (ok amount)
  )
)

(define-read-only (get-total-tips)
  (var-get total-tips)
)

(define-read-only (get-user-tips (user principal))
  (default-to u0 (map-get? tips user))
)
