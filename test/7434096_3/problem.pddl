(define (problem task-7434096-3)
  (:domain appworld-7434096-3)
  (:objects
    tracy-weber - person
    tra-weber-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-gildan-womens-softstyle-cotton-t-shirt - query
    order-1 order-2 - order
    tshirt-large tshirt-other-1 tshirt-other-2 - product
    fedex - deliverer
    quantity-1 - quantity)
  (:init
    (username-for amazon tra-weber-at-gmail-com)
    (password-for amazon amazon-password)
    (search-query query-gildan-womens-softstyle-cotton-t-shirt)
    (item-in-order tshirt-large order-1)
    (item-in-order tshirt-other-1 order-1)
    (item-in-order tshirt-other-2 order-2)
    (fits tshirt-large)
    (item-quantity tshirt-other-1 quantity-1)
    (item-quantity tshirt-other-2 quantity-1)
    (deliverer-available fedex)
    (preferred-deliverer fedex))
  (:goal (and
    (return-initiated order-1 tshirt-other-1 fedex)
    (return-initiated order-2 tshirt-other-2 fedex)
    (task-completed)))
)
