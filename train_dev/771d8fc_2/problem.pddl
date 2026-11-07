(define (problem task-771d8fc-2)
  (:domain appworld-771d8fc-2)
  (:objects
    nicholas-weber - person
    username-9503658964 - username
    phone-password - password
    phone-token - token
    number-9294880327 - phone-number
    text-msg-from-9294880327 - text-message
    voice-msg-from-9294880327 - voice-message)
  (:init
    (username-for phone username-9503658964)
    (password-for phone phone-password)
    (spam-number number-9294880327)
    (from-number text-msg-from-9294880327 number-9294880327)
    (from-number voice-msg-from-9294880327 number-9294880327))
  (:goal (and
    (deleted text-msg-from-9294880327)
    (deleted voice-msg-from-9294880327)
    (task-completed)))
)
