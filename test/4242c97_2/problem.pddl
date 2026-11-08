(define (problem task-4242c97-2)
  (:domain appworld-4242c97-2)
  (:objects
    bradley-ball - person
    bradley-ball-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-nordstrom-signature-cashmere-sweater - query
    extra-small - size
    yellow orange navy-blue no-fallback-color - color
    sweater-xs-yellow sweater-xs-orange sweater-xs-navy-blue - product
    quantity-2 - quantity
    flag-true - flag
    amazon-payment-card - payment-card
    amazon-address - address
    order-two-sweaters - order)
  (:init
    (is-supervisor bradley-ball)
    (username-for amazon bradley-ball-at-gmail-com)
    (password-for amazon amazon-password)
    (named-by sweater-xs-yellow query-nordstrom-signature-cashmere-sweater)
    (named-by sweater-xs-orange query-nordstrom-signature-cashmere-sweater)
    (named-by sweater-xs-navy-blue query-nordstrom-signature-cashmere-sweater)
    (sweater-variant sweater-xs-yellow yellow extra-small)
    (sweater-variant sweater-xs-orange orange extra-small)
    (sweater-variant sweater-xs-navy-blue navy-blue extra-small)
    (may-search yellow)
    (next-preferred-color yellow orange)
    (next-preferred-color orange navy-blue)
    (next-preferred-color navy-blue no-fallback-color)
    (is-true flag-true))
  (:goal (and (order-placed order-two-sweaters) (ordered-sweater order-two-sweaters extra-small quantity-2) (task-completed)))
)
