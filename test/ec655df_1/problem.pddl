(define (problem task-ec655df-1)
  (:domain appworld-ec655df-1)
  (:objects
    catherine-smith - person
    ca-smit-at-gmail-com - username
    gmail-password amazon-password - password
    gmail-token amazon-token - token
    query-get-together query-amazfit-band-5-fitness-tracker - query
    get-together-thread - email-thread
    amazfit-band-5-fitness-tracker - product
    qty-rsvp-yes - quantity
    home-address - address
    amazon-payment-card - payment-card
    flag-true - flag
  )
  (:init
    (password-for gmail gmail-password)
    (password-for amazon amazon-password)
    (username-for gmail ca-smit-at-gmail-com)
    (username-for amazon ca-smit-at-gmail-com)
    (thread-matches query-get-together get-together-thread)
    (rsvp-count-of get-together-thread qty-rsvp-yes)
    (product-query query-amazfit-band-5-fitness-tracker amazfit-band-5-fitness-tracker)
    (is-home-address home-address)
    (is-true flag-true)
  )
  (:goal (and
    (order-placed amazfit-band-5-fitness-tracker qty-rsvp-yes home-address)
    (task-completed)
  ))
)
