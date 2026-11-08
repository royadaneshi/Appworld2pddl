(define (problem task-fdc4b74-2)
  (:domain appworld-fdc4b74-2)
  (:objects
    jason-simpson manager - person
    jasonsimp-at-gmail-com - username
    gmail-password - password
    gmail-token - token
    draft-camping-trip - draft
    query-camping query-camping-item-1 query-camping-item-2 query-camping-item-3 - query
    camping-item-1 camping-item-2 camping-item-3 no-more-items - product
    total-price-item-1 total-price-item-2 total-price-item-3 - price
    body-with-prices - body
  )
  (:init
    (password-for gmail gmail-password)
    (draft-to draft-camping-trip manager)
    (draft-matches draft-camping-trip query-camping)
    (lists-product draft-camping-trip camping-item-1)
    (lists-product draft-camping-trip camping-item-2)
    (lists-product draft-camping-trip camping-item-3)
    (product-query camping-item-1 query-camping-item-1)
    (product-query camping-item-2 query-camping-item-2)
    (product-query camping-item-3 query-camping-item-3)
    (price-of camping-item-1 total-price-item-1)
    (price-of camping-item-2 total-price-item-2)
    (price-of camping-item-3 total-price-item-3)
    (price-cursor draft-camping-trip camping-item-1)
    (next-product camping-item-1 camping-item-2)
    (next-product camping-item-2 camping-item-3)
    (next-product camping-item-3 no-more-items)
    (end-of-list no-more-items)
    (body-for body-with-prices draft-camping-trip)
  )
  (:goal (and
    (prices-filled draft-camping-trip)
    (email-sent draft-camping-trip)
    (draft-deleted draft-camping-trip)
    (task-completed)
  ))
)
