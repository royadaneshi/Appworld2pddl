(define (problem task-13547f5-3)
  (:domain appworld-13547f5-3)
  (:objects
    katie husband - person
    username-6727300099 - username
    phone-password - password
    phone-token - token
    rel-husband - relationship
    husband-phone - phone-number
    msg-dont-forget-to-water-the-plants-today - message)
  (:init
    (password-for phone phone-password)
    (has-relationship husband rel-husband)
    (phone-of husband husband-phone)
    (target-person husband)
    (target-message msg-dont-forget-to-water-the-plants-today))
  (:goal (and
    (voice-message-sent husband-phone msg-dont-forget-to-water-the-plants-today)
    (task-completed))))
