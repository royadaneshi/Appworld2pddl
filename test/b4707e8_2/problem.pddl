(define (problem task-b4707e8-2)
  (:domain appworld-b4707e8-2)
  (:objects
    robert - person
    robertmartinez-at-gmail-com - username
    simple-note-password amazon-password - password
    simple-note-token amazon-token - token
    query-amazon-expenses - query
    amazon-expense-log-note - note
    may-2023 - month
    amount-may-2023-total - amount
    entry-may-2023 - content
    append - position)
  (:init
    (username-for simple-note robertmartinez-at-gmail-com)
    (username-for amazon robertmartinez-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for amazon amazon-password)
    (token-for simple-note simple-note-token)
    (token-for amazon amazon-token)
    (query-for query-amazon-expenses amazon-expense-log-note)
    (expense-log amazon-expense-log-note)
    (current-month may-2023)
    (total-for may-2023 amount-may-2023-total)
    (entry-for entry-may-2023 may-2023 amount-may-2023-total)
    (append-position append))
  (:goal (and (note-updated amazon-expense-log-note may-2023) (task-completed)))
)
