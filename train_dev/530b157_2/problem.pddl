(define (problem task-530b157-2)
  (:domain appworld-530b157-2)
  (:objects
    morgan joseph - person
    phone-8903665635 morgan-harrison-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    joseph-email - email
    joseph-phone - phone-number
    query-joseph - query
    grocery-amount - amount
    desc-grocery-bill - description
    msg-done - message)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (username-for phone phone-8903665635)
    (username-for venmo morgan-harrison-at-gmail-com)
    (query-matches query-joseph joseph)
    (contact-email joseph joseph-email)
    (contact-phone joseph joseph-phone)
    (owed-amount joseph grocery-amount))
  (:goal (and
    (money-sent joseph grocery-amount desc-grocery-bill)
    (text-sent joseph msg-done)
    (task-completed)))
)
