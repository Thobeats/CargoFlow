;; Define data variables and maps
(define-data-var cargo-count uint u0)

(define-map cargos 
  {id: uint} 
  {
    description: (string-ascii 100),
    status: (string-ascii 20),
    owner: principal
  }
)

;; Define constants for error handling
(define-constant ERR_CARGO_NOT_FOUND (err u100))
(define-constant ERR_NOT_OWNER (err u101))

;; Add a new cargo
(define-public (add-cargo (description (string-ascii 100)))
  (let
    (
      (cargo-id (var-get cargo-count))
    )
    (map-set cargos
      {id: cargo-id}
      {
        description: description,
        status: "Pending",
        owner: tx-sender
      }
    )
    (var-set cargo-count (+ cargo-id u1))
    (ok cargo-id)
  )
)

;; Update the status of a cargo
(define-public (update-cargo-status (cargo-id uint) (new-status (string-ascii 20)))
  (let 
    (
      (cargo (map-get? cargos {id: cargo-id}))
    )
    (match cargo
      cargo-data
        (if (is-eq (get owner cargo-data) tx-sender)
          (begin
            (map-set cargos
              {id: cargo-id}
              (merge cargo-data {status: new-status})
            )
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
  (match (map-get? cargos {id: cargo-id})
    cargo-data (ok cargo-data)
    ERR_CARGO_NOT_FOUND
  )
)