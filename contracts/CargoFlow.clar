(define-data-var cargo-count uint 0)

(define-map cargos 
  ((id uint)) ;; Cargo ID
  (
    (description (string-ascii 100)) ;; Cargo description
    (status (string-ascii 20)) ;; Status of the cargo
    (owner principal) ;; Owner of the cargo
  )
)

(define-constant ERR_CARGO_NOT_FOUND (err u100))
(define-constant ERR_NOT_OWNER (err u101))

;; Add a new cargo
(define-public (add-cargo (description (string-ascii 100)))
  (begin
    (let ((cargo-id (var-get cargo-count)))
      (map-insert cargos
        ((id cargo-id))
        (
          (description description)
          (status "Pending")
          (owner tx-sender)
        ))
      (var-set cargo-count (+ cargo-id u1))
      (ok cargo-id)
    )
  )
)

;; Update the status of a cargo
(define-public (update-cargo-status (cargo-id uint) (new-status (string-ascii 20)))
  (let (
    (cargo (map-get? cargos ((id cargo-id))))
  )
    (match cargo
      cargo-data
      (if (is-eq (get owner cargo-data) tx-sender)
        (begin
          (map-set cargos
            ((id cargo-id))
            (
              (description (get description cargo-data))
              (status new-status)
              (owner (get owner cargo-data))
            ))
          (ok true)
        )
        ERR_NOT_OWNER
      )
      ERR_CARGO_NOT_FOUND
    )
  )
)

;; Get cargo details
(define-read-only (get-cargo (cargo-id uint))
  (let (
    (cargo (map-get? cargos ((id cargo-id))))
  )
    (match cargo
      some-data (ok some-data)
      none ERR_CARGO_NOT_FOUND
    )
  )
)
