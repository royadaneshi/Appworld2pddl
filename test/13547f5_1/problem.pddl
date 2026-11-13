(define (problem task-13547f5-1)
  (:domain appworld-13547f5-1)
  (:objects
    anita - person
    phone-username-3643463570 - username
    phone-password - password
    phone-token - token
    roommate - relationship
    roommate-number-1 roommate-number-2 roommate-number-3 - phone-number
  )
  (:init
    (password-for phone phone-password)
    (has-relationship roommate-1 roommate)
    (has-relationship roommate-2 roommate)
    (has-relationship roommate-3 roommate)
    (has-phone-number roommate-1 roommate-number-1)
    (has-phone-number roommate-2 roommate-number-2)
    (has-phone-number roommate-3 roommate-number-3))
  (:goal (and
    (voice-message-sent roommate-1 msg-i-have-taken-out-the-trash)
    (voice-message-sent roommate-2 msg-i-have-taken-out-the-trash)
    (voice-message-sent roommate-3 msg-i-have-taken-out-the-trash)
    (task-completed))))
