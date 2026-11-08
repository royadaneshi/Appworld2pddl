(define (problem task-b6d1104-2)
  (:domain appworld-b6d1104-2)
  (:objects
    chris - person
    chris-mcco-at-gmail-com - username
    venmo-password simple-note-password - password
    venmo-token simple-note-token - token
    venmo-expenses-note - note
    query-venmo-expenses - query
    new-content - content
    this-month-expense - amount
    direction-sent - direction
    datetime-2023-05-01 datetime-2023-05-31 - datetime
  )
  (:init
    (username-for venmo chris-mcco-at-gmail-com)
    (username-for simple-note chris-mcco-at-gmail-com)
    (password-for venmo venmo-password)
    (password-for simple-note simple-note-password)
    (sent-direction direction-sent)
    (this-month-start datetime-2023-05-01)
    (this-month-end datetime-2023-05-31)
    (note-matches query-venmo-expenses venmo-expenses-note)
    (content-with-entry new-content venmo-expenses-note this-month-expense)
  )
  (:goal (and
    (note-updated venmo-expenses-note this-month-expense)
    (task-completed)
  ))
)
