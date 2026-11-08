(define (problem task-13547f5-2)
  (:domain appworld-13547f5-2)
  (:objects
    sabrina-brown partner-contact - person
    username-6639773608 - username
    phone-password - password
    phone-token - token
    partner - relationship
    partner-phone-number - phone-number
    message-dishwasher-clean - message)
  (:init
    (password-for phone phone-password)
    (username-for phone username-6639773608)
    (has-relationship partner-contact partner)
    (has-phone-number partner-contact partner-phone-number))
  (:goal (and (message-sent-to partner-contact message-dishwasher-clean) (task-completed))))
