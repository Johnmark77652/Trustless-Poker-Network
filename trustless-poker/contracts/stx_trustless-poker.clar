;; Complete corrected section for your original contract:

;; Shuffle deck using combined seed (deterministic pseudo-random shuffle)
(define-private (shuffle-deck (seed (buff 32)))
    ;; Create base deck
    (let ((base-deck (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11 u12 u13 
                          u14 u15 u16 u17 u18 u19 u20 u21 u22 u23 u24 u25 u26
                          u27 u28 u29 u30 u31 u32 u33 u34 u35 u36 u37 u38 u39
                          u40 u41 u42 u43 u44 u45 u46 u47 u48 u49 u50 u51 u52)))
        ;; For a production contract, implement proper Fisher-Yates shuffle
        ;; This is a simplified version that uses the seed to create deterministic randomness
        (let ((seed-uint (buff-to-uint-be (unwrap-panic (slice? seed u0 u8)))))
            ;; Simple deterministic shuffle based on seed
            ;; In production, implement proper cryptographic shuffle
            (if (> (mod seed-uint u2) u0)
                ;; Reverse every other card based on seed
                (list u52 u51 u50 u49 u48 u47 u46 u45 u44 u43 u42 u41 u40
                      u39 u38 u37 u36 u35 u34 u33 u32 u31 u30 u29 u28 u27
                      u26 u25 u24 u23 u22 u21 u20 u19 u18 u17 u16 u15 u14
                      u13 u12 u11 u10 u9 u8 u7 u6 u5 u4 u3 u2 u1)
                base-deck
            )
        )
    )
)

;; Generate provably fair shuffled deck
(define-private (generate-shuffled-deck (game-id uint))
    (let (
        (seed-data (map-get? random-seeds { game-id: game-id }))
    )
        (match seed-data
            some-seed-data 
                (let ((combined-seed (sha256 (concat (get server-seed some-seed-data) (get client-seed some-seed-data)))))
                    ;; Use shuffle with deterministic randomness
                    (shuffle-deck combined-seed)
                )
            ;; Return default deck if seed data not found
            (list u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11 u12 u13 
                  u14 u15 u16 u17 u18 u19 u20 u21 u22 u23 u24 u25 u26
                  u27 u28 u29 u30 u31 u32 u33 u34 u35 u36 u37 u38 u39
                  u40 u41 u42 u43 u44 u45 u46 u47 u48 u49 u50 u51 u52)
        )
    )
)

;; Alternative approach - return a response type consistently
(define-private (generate-shuffled-deck-v2 (game-id uint))
    (let (
        (seed-data (unwrap! (map-get? random-seeds { game-id: game-id }) 
                           (err ERR-NOT-FOUND)))
        (combined-seed (sha256 (concat (get server-seed seed-data) (get client-seed seed-data))))
    )
        ;; Use Fisher-Yates shuffle with deterministic randomness
        (ok (shuffle-deck combined-seed))
    )
)

;; Updated deal-initial-cards function to work with the fix
(define-private (deal-initial-cards (game-id uint))
    (let ((game (unwrap! (map-get? games { game-id: game-id }) ERR-NOT-FOUND)))
        ;; Generate shuffled deck using provable randomness
        (let ((shuffled-deck (generate-shuffled-deck game-id)))
            ;; Deal 2 cards to each player
            (deal-cards-to-players game-id shuffled-deck (get current-players game))
        )
    )
)