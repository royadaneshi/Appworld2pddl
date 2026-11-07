(define (problem task-771d8fc-1)
  (:domain appworld-771d8fc-1)
  (:objects
    edwin-wilson - person
    username-8506051563 - username
    phone-password - password
    phone-token - token
    number-3654328626 - phone-number
    text-msg-1 text-msg-2 - text-message
    voice-msg-1 voice-msg-2 - voice-message)
  (:init
    (username-for phone username-8506051563)
    (password-for phone phone-password)
    (text-from text-msg-1 number-3654328626)
    (text-from text-msg-2 number-3654328626)
    (voice-from voice-msg-1 number-3654328626)
    (voice-from voice-msg-2 number-3654328626))
  (:goal (and
    (text-deleted text-msg-1)
    (text-deleted text-msg-2)
    (voice-deleted voice-msg-1)
    (voice-deleted voice-msg-2)
    (task-completed)))
)
