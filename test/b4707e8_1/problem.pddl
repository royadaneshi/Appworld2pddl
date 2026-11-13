(define (problem task-b4707e8-1)
  (:domain appworld-b4707e8-1)
  (:objects
    dillon-wilson - person
    diwils-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-expenses - query
    amazon-expense-log-note - note
    month-2023-05 - month
    amount-2023-05-total - amount
    entry-line-2023-05 - content
    append - position
  )
  (:init
    (credential-of-app simple-note diwils-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app amazon diwils-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (username-for simple-note diwils-at-gmail-com)
    (username-for amazon diwils-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (note-query query-amazon-expenses amazon-expense-log-note)
    (current-month month-2023-05)
    (amount-for-month month-2023-05 amount-2023-05-total)
    (entry-content entry-line-2023-05 month-2023-05 amount-2023-05-total)
    (append-mode append)
  )
  (:goal (and
    (note-updated amazon-expense-log-note month-2023-05)
    (task-completed)
  ))
)
