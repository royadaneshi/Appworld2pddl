(define (problem task-fdc4b74-1)
  (:domain appworld-fdc4b74-1)
  (:objects
    stephen-mccoy - person
    stmcco-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    camping-items-draft - draft
    query-camping query-product-1 query-product-2 query-product-3 - query
    product-1 product-2 product-3 - product
    body-with-prices - body)
  (:init
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (draft-query camping-items-draft query-camping)
    (listed-in product-1 camping-items-draft)
    (listed-in product-2 camping-items-draft)
    (listed-in product-3 camping-items-draft)
    (product-query product-1 query-product-1)
    (product-query product-2 query-product-2)
    (product-query product-3 query-product-3)
    (body-of body-with-prices camping-items-draft))
  (:goal (and (email-sent camping-items-draft) (task-completed))))
