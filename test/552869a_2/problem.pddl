(define (problem task-552869a-2)
  (:domain appworld-552869a-2)
  (:objects
    jose - person
    joseharr-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    query-electricity-bill - query
    datetime-2023-01-01t00-00-00 - datetime
    direction-sent - direction
    total-electricity-paid-this-year - amount
  )
  (:init
    (password-for venmo venmo-password)
    (target-filter query-electricity-bill datetime-2023-01-01t00-00-00 direction-sent)
  )
  (:goal (and
    (found-total total-electricity-paid-this-year)
    (task-completed)
  ))
)
