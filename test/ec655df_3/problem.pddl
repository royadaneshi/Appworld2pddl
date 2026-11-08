(define (problem task-ec655df-3)
  (:domain appworld-ec655df-3)
  (:objects
    paul-miller - person
    paul-mill-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-get-together query-ticket-to-ride-board-game - query
    rsvp-thread - email-thread
    ticket-to-ride-board-game - product
    quantity-rsvp-yes - quantity
    paul-home-address - address
    paul-payment-card - payment-card)
  (:init
    (username-for gmail paul-mill-at-gmail-com)
    (username-for amazon paul-mill-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-query query-get-together rsvp-thread)
    (rsvp-count-of rsvp-thread quantity-rsvp-yes)
    (product-query query-ticket-to-ride-board-game ticket-to-ride-board-game)
    (home-address-of paul-miller paul-home-address))
  (:goal (and
    (order-placed ticket-to-ride-board-game quantity-rsvp-yes paul-home-address)
    (task-completed)))
)
