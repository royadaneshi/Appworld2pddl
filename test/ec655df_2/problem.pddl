(define (problem task-ec655df-2)
  (:domain appworld-ec655df-2)
  (:objects
    sherry - person
    she-bailey-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-get-together query-wahl-elite-pro-hair-clipper - query
    rsvp-thread - email-thread
    qty-rsvp-yes - quantity
    wahl-elite-pro-hair-clipper - product
    sherry-home-address - address
    sherry-payment-card - payment-card
    order-1 - order
  )
  (:init
    (username-for gmail she-bailey-at-gmail-com)
    (username-for amazon she-bailey-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (thread-query query-get-together rsvp-thread)
    (rsvp-count-of rsvp-thread qty-rsvp-yes)
    (product-query query-wahl-elite-pro-hair-clipper wahl-elite-pro-hair-clipper)
    (target-product wahl-elite-pro-hair-clipper)
    (home-address sherry-home-address)
  )
  (:goal (and
    (ordered order-1 wahl-elite-pro-hair-clipper qty-rsvp-yes sherry-home-address)
    (task-completed)
  ))
)
