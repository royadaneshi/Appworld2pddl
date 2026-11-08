(define (problem task-32616b5-2)
  (:domain appworld-32616b5-2)
  (:objects
    connor coworker-1 coworker-2 coworker-3 - person
    connor-username - username
    simple-note-pw splitwise-pw - password
    sn-token sw-token - token
    connorbrow-at-gmail-com coworker-1-email coworker-2-email coworker-3-email - email
    query-trip - query
    trip-note - note
    group-trip-1 group-trip-2 - trip-group
    amount-1 amount-2 amount-3 amount-4 - amount
    desc-1 desc-2 desc-3 desc-4 - description
  )
  (:init
    (password-for simple-note simple-note-pw)
    (password-for splitwise splitwise-pw)
    (token-for simple-note sn-token)
    (token-for splitwise sw-token)
    (note-matches trip-note query-trip)
    (email-of connor connorbrow-at-gmail-com)
    (email-of coworker-1 coworker-1-email)
    (email-of coworker-2 coworker-2-email)
    (email-of coworker-3 coworker-3-email)
    (member-of group-trip-1 connor)
    (member-of group-trip-1 coworker-1)
    (member-of group-trip-1 coworker-2)
    (member-of group-trip-2 connor)
    (member-of group-trip-2 coworker-2)
    (member-of group-trip-2 coworker-3)
    (entry-in-note entry-1 trip-note)
    (entry-in-note entry-2 trip-note)
    (entry-in-note entry-3 trip-note)
    (entry-in-note entry-4 trip-note)
    (entry-group entry-1 group-trip-1)
    (entry-group entry-2 group-trip-1)
    (entry-group entry-3 group-trip-2)
    (entry-group entry-4 group-trip-2)
    (entry-payer entry-1 connor)
    (entry-debtor entry-1 coworker-1)
    (entry-payer entry-2 coworker-2)
    (entry-debtor entry-2 connor)
    (entry-payer entry-3 connor)
    (entry-debtor entry-3 coworker-3)
    (entry-payer entry-4 coworker-3)
    (entry-debtor entry-4 coworker-2)
    (entry-amount entry-1 amount-1)
    (entry-amount entry-2 amount-2)
    (entry-amount entry-3 amount-3)
    (entry-amount entry-4 amount-4)
    (entry-description entry-1 desc-1)
    (entry-description entry-2 desc-2)
    (entry-description entry-3 desc-3)
    (entry-description entry-4 desc-4)
  )
  (:goal (and
    (expense-recorded entry-1)
    (expense-recorded entry-2)
    (expense-recorded entry-3)
    (expense-recorded entry-4)
    (task-completed)
  ))
)
