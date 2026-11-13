(define (problem task-522e5e5-2)
  (:domain appworld-522e5e5-2)
  (:objects
    matthew-blackburn - person
    matthew-blac-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    direction-sent - direction
    datetime-2023-05-01t00-00-00 - datetime
    recipient-email-1 recipient-email-2 recipient-email-3 recipient-email-4 recipient-email-5 recipient-email-6 recipient-email-7 recipient-email-8 recipient-email-9 - email
  )
  (:init
    (username-for venmo matthew-blac-at-gmail-com)
    (password-for venmo venmo-password)
    (filter-direction direction-sent)
    (filter-min-date datetime-2023-05-01t00-00-00)
    (sent-money-this-month recipient-1)
    (sent-money-this-month recipient-2)
    (sent-money-this-month recipient-3)
    (sent-money-this-month recipient-4)
    (sent-money-this-month recipient-5)
    (sent-money-this-month recipient-6)
    (sent-money-this-month recipient-7)
    (sent-money-this-month recipient-8)
    (sent-money-this-month recipient-9)
    (email-of recipient-1 recipient-email-1)
    (email-of recipient-2 recipient-email-2)
    (email-of recipient-3 recipient-email-3)
    (email-of recipient-4 recipient-email-4)
    (email-of recipient-5 recipient-email-5)
    (email-of recipient-6 recipient-email-6)
    (email-of recipient-7 recipient-email-7)
    (email-of recipient-8 recipient-email-8)
    (email-of recipient-9 recipient-email-9))
  (:goal (and
    (friend recipient-1)
    (friend recipient-2)
    (friend recipient-3)
    (friend recipient-4)
    (friend recipient-5)
    (friend recipient-6)
    (friend recipient-7)
    (friend recipient-8)
    (friend recipient-9)
    (task-completed))))
