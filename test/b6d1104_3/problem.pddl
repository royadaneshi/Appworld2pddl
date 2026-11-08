(define (problem task-b6d1104-3)
  (:domain appworld-b6d1104-3)
  (:objects
    troy - person
    tr-solo-at-gmail-com - username
    simple-note-password venmo-password - password
    simple-note-token venmo-token - token
    query-venmo-expenses - query
    venmo-expenses-note - note
    month-05-23 - month
    amount-total-sent-05-23 - amount
    content-with-05-23-entry - content
    direction-sent - direction
    datetime-2023-05-01t00-00-00 datetime-2023-05-31t23-59-59 - datetime
  )
  (:init
    (password-for simple-note simple-note-password)
    (password-for venmo venmo-password)
    (query-for-note query-venmo-expenses venmo-expenses-note)
    (this-month month-05-23)
    (month-range month-05-23 datetime-2023-05-01t00-00-00 datetime-2023-05-31t23-59-59)
    (expense-direction direction-sent)
    (expense-of month-05-23 amount-total-sent-05-23)
    (content-with-entry content-with-05-23-entry venmo-expenses-note month-05-23 amount-total-sent-05-23)
  )
  (:goal (and
    (note-updated venmo-expenses-note content-with-05-23-entry)
    (task-completed)
  ))
)
