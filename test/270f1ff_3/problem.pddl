(define (problem task-270f1ff-3)
  (:domain appworld-270f1ff-3)
  (:objects
    sabrina son - person
    phone-6639773608 sab-brown-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    relationship-son - relationship
    son-email - email
    son-phone-number - phone-number
    direction-sent - direction
    datetime-2022-05-18t00-00-00 datetime-2022-05-18t23-59-59 - datetime
    amount-last-birthday amount-four-times-last-birthday - amount
    note-have-a-great-day - note
    privacy-private - privacy
    message-happy-birthday-son - message)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-6639773608)
    (username-for venmo sab-brown-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship son relationship-son)
    (birthday-window son datetime-2022-05-18t00-00-00 datetime-2022-05-18t23-59-59)
    (four-times amount-four-times-last-birthday amount-last-birthday))
  (:goal (and
    (transaction-sent son amount-four-times-last-birthday note-have-a-great-day privacy-private)
    (text-sent son message-happy-birthday-son)
    (task-completed))))
