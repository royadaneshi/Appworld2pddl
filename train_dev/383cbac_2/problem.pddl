(define (problem task-383cbac-2)
  (:domain appworld-383cbac-2)
  (:objects
    anita - person
    phone-username-3643463570 venmo-username-anita-burch-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker query-manager - query
    total-manager-paid - amount)
  (:init
    (username-for phone phone-username-3643463570)
    (username-for venmo venmo-username-anita-burch-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for venmo venmo-token)
    (query-for query-coworker rel-coworker)
    (query-for query-manager rel-manager))
  (:goal (and (found-total total-manager-paid) (task-completed))))
