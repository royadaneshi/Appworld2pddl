(define (problem task-b4707e8-3)
  (:domain appworld-b4707e8-3)
  (:objects
    claudia - person
    clmiller-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-expenses - query
    amazon-expense-log-note - note
    total-may-2023 - amount
    entry-may-2023 - content
    append - position)
  (:init
    (credential-of-app simple-note clmiller-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon clmiller-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-matches query-amazon-expenses amazon-expense-log-note)
    (current-month-amount total-may-2023)
    (entry-for entry-may-2023 total-may-2023)
    (is-append append))
  (:goal (and
    (note-updated amazon-expense-log-note entry-may-2023)
    (task-completed))))
