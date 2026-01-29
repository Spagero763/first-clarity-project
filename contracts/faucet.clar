;; Testnet Faucet Contract
;; A faucet that distributes test tokens with rate limiting

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant err-not-owner (err u100))
(define-constant err-cooldown (err u101))
(define-constant err-empty-faucet (err u102))
(define-constant err-already-claimed (err u103))

;; Distribution amount and cooldown
(define-constant DRIP_AMOUNT u1000000) ;; 1 STX in micro-STX
(define-constant COOLDOWN_BLOCKS u144) ;; ~24 hours

;; Data maps
(define-map last-claim principal uint)
(define-map total-claimed principal uint)
(define-data-var total-distributed uint u0)
(define-data-var faucet-enabled bool true)

;; Claim tokens from faucet
(define-public (claim)
  (let (
    (last-block (default-to u0 (map-get? last-claim tx-sender)))
    (faucet-balance (stx-get-balance (as-contract tx-sender)))
  )
    (asserts! (var-get faucet-enabled) err-not-owner)
    (asserts! (>= faucet-balance DRIP_AMOUNT) err-empty-faucet)
    (asserts! (>= block-height (+ last-block COOLDOWN_BLOCKS)) err-cooldown)
    
    (try! (as-contract (stx-transfer? DRIP_AMOUNT tx-sender tx-sender)))
    
    (map-set last-claim tx-sender block-height)
    (map-set total-claimed tx-sender 
      (+ DRIP_AMOUNT (default-to u0 (map-get? total-claimed tx-sender)))
    )
    (var-set total-distributed (+ (var-get total-distributed) DRIP_AMOUNT))
    
    (ok DRIP_AMOUNT)
  )
)

;; Fund the faucet
(define-public (fund (amount uint))
  (stx-transfer? amount tx-sender (as-contract tx-sender))
)

;; Admin: Enable/disable faucet
(define-public (set-enabled (enabled bool))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) err-not-owner)
    (var-set faucet-enabled enabled)
    (ok enabled)
  )
)

;; Admin: Emergency withdraw
(define-public (withdraw (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) err-not-owner)
    (as-contract (stx-transfer? amount tx-sender CONTRACT-OWNER))
  )
)

;; Read-only functions
(define-read-only (get-drip-amount)
  DRIP_AMOUNT
)

(define-read-only (get-cooldown)
  COOLDOWN_BLOCKS
)

(define-read-only (get-faucet-balance)
  (stx-get-balance (as-contract tx-sender))
)

(define-read-only (get-last-claim (user principal))
  (default-to u0 (map-get? last-claim user))
)

(define-read-only (can-claim (user principal))
  (let (
    (last-block (get-last-claim user))
  )
    (and 
      (var-get faucet-enabled)
      (>= (stx-get-balance (as-contract tx-sender)) DRIP_AMOUNT)
      (>= block-height (+ last-block COOLDOWN_BLOCKS))
    )
  )
)

(define-read-only (get-total-distributed)
  (var-get total-distributed)
)

(define-read-only (get-user-total (user principal))
  (default-to u0 (map-get? total-claimed user))
)
