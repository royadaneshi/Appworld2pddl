(define (problem task-b6d1104-1)
  (:domain appworld-b6d1104-1)
  (:objects
    martin - person
    mar-blac-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-venmo-expenses - query
    venmo-expenses-note - note
    content-with-may-2023-entry - content
    direction-sent - direction
    datetime-2023-05-01t00-00-00 datetime-2023-05-31t23-59-59 - datetime
    month-05-23 - month
    amount-may-2023-expense - amount
  )
  (:init
    (username-for simple-note mar-blac-at-gmail-com)
    (username-for venmo mar-blac-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (note-matches venmo-expenses-note query-venmo-expenses)
    (this-month month-05-23)
    (month-range month-05-23 datetime-2023-05-01t00-00-00 datetime-2023-05-31t23-59-59)
    (outgoing direction-sent)
    (content-with-entry content-with-may-2023-entry venmo-expenses-note month-05-23 amount-may-2023-expense)
  )
  (:goal (and
    (note-updated venmo-expenses-note month-05-23 amount-may-2023-expense)
    (task-completed)
  ))
)
