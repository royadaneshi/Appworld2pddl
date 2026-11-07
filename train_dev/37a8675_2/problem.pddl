(define (problem task-37a8675-2)
  (:domain appworld-37a8675-2)
  (:objects
    spencer contact - person
    phone-username-8267279358 venmo-username-spencer-powell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-5734599766 - query
    contact-email - email
    card-non-expired - card
    amount-100 - amount
    description-payment - description
    public - privacy
    tx-1 - transaction
  )
  (:init
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (login-username phone phone-username-8267279358)
    (login-username venmo venmo-username-spencer-powell-at-gmail-com)
    (contact-query contact query-5734599766)
    (tx-receiver tx-1 contact)
    (tx-amount tx-1 amount-100)
    (tx-privacy tx-1 public)
  )
  (:goal (and (sent tx-1) (task-completed)))
)
