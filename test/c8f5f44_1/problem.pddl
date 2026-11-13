(define (problem task-c8f5f44-1)
  (:domain appworld-c8f5f44-1)
  (:objects
    katherine brother - person
    ka-ball-at-gmail-com phone-7863159797 - username
    pw-phone pw-venmo pw-amazon - password
    token-phone token-venmo token-amazon - token
    brother-email - email
    rel-brother - relationship
    direction-received - direction
    query-requested-product - query
    qty-1 - quantity
    comment-thank-you - comment
    requested-product - product
    home-address - address
    payment-card-1 - payment-card
    brother-transaction - transaction
  )
  (:init
    (credential-of-app phone phone-7863159797)
    (credential-of-app phone pw-phone)
    (credential-of-app phone token-phone)
    (credential-of-app venmo ka-ball-at-gmail-com)
    (credential-of-app venmo pw-venmo)
    (credential-of-app venmo token-venmo)
    (credential-of-app amazon ka-ball-at-gmail-com)
    (credential-of-app amazon pw-amazon)
    (credential-of-app amazon token-amazon)
    (username-for phone phone-7863159797)
    (username-for venmo ka-ball-at-gmail-com)
    (username-for amazon ka-ball-at-gmail-com)
    (password-for phone pw-phone)
    (password-for venmo pw-venmo)
    (password-for amazon pw-amazon)
    (has-relationship brother rel-brother)
    (email-of brother brother-email)
    (transaction-from brother-transaction brother)
    (transaction-for brother-transaction requested-product)
    (query-for query-requested-product requested-product)
    (is-home-address home-address)
  )
  (:goal (and
    (ordered requested-product home-address)
    (commented brother-transaction comment-thank-you)
    (task-completed)
  ))
)
