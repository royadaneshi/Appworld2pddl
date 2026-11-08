(define (problem task-522e5e5-2)
  (:domain appworld-522e5e5-2)
  (:objects
    matthew-blackburn - person
    matthew-blac-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    recipient-1-email recipient-2-email - email
    direction-sent - direction
    datetime-2023-05-01t00-00-00 - datetime)
  (:init
    (username-for venmo matthew-blac-at-gmail-com)
    (password-for venmo venmo-password)
    (filter-direction direction-sent)
    (filter-min-date datetime-2023-05-01t00-00-00)
    (sent-money-this-month recipient-1)
    (sent-money-this-month recipient-2)
    (email-of recipient-1 recipient-1-email)
    (email-of recipient-2 recipient-2-email))
  (:goal (and (friend recipient-1)
              (friend recipient-2)
              (task-completed))))
