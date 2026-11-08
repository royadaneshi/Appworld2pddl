(define (problem task-4815c06-1)
  (:domain appworld-4815c06-1)
  (:objects
    jeffrey-smith - person
    jefsmith-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-sony-playstation-5 query-etekcity-food-kitchen-scale query-xbox-series-s-console - query
    sony-playstation-5 etekcity-food-kitchen-scale xbox-series-s-console original-cart-product - product
    quantity-1 original-quantity - quantity
    chosen-payment-card - payment-card
    home-address - address
    order-1 - order)
  (:init
    (password-for amazon amazon-password)
    (search-query-for sony-playstation-5 query-sony-playstation-5)
    (search-query-for etekcity-food-kitchen-scale query-etekcity-food-kitchen-scale)
    (search-query-for xbox-series-s-console query-xbox-series-s-console)
    (wanted sony-playstation-5)
    (wanted etekcity-food-kitchen-scale)
    (wanted xbox-series-s-console)
    (target-quantity sony-playstation-5 quantity-1)
    (target-quantity etekcity-food-kitchen-scale quantity-1)
    (target-quantity xbox-series-s-console quantity-1)
    (original-entry original-cart-product)
    (target-quantity original-cart-product original-quantity)
    (in-cart original-cart-product)
    (preferred-card chosen-payment-card)
    (is-home-address home-address))
  (:goal (and
    (order-placed order-1)
    (order-contains order-1 sony-playstation-5)
    (order-contains order-1 etekcity-food-kitchen-scale)
    (order-contains order-1 xbox-series-s-console)
    (order-paid-with order-1 chosen-payment-card)
    (order-shipped-to order-1 home-address)
    (in-cart original-cart-product)
    (not (in-cart sony-playstation-5))
    (not (in-cart etekcity-food-kitchen-scale))
    (not (in-cart xbox-series-s-console))
    (task-completed)))
)
