(define (problem task-13547f5-1)
  (:domain appworld-13547f5-1)
  (:objects
    anita - person
    phone-username-3643463570 - username
    phone-password - password
    phone-token - token
    roommate-1-number roommate-2-number - phone-number
    roommate - relationship)
  (:init
    (password-for phone phone-password)
    (has-relationship roommate-1 roommate)
    (has-relationship roommate-2 roommate)
    (has-phone-number roommate-1 roommate-1-number)
    (has-phone-number roommate-2 roommate-2-number))
  (:goal (and
    (voice-message-sent roommate-1 msg-i-have-taken-out-the-trash)
    (voice-message-sent roommate-2 msg-i-have-taken-out-the-trash)
    (task-completed))))
