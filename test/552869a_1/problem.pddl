(define (problem task-552869a-1)
  (:domain appworld-552869a-1)
  (:objects
    jordan-harrison - person
    jo-harr-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    query-phone-bill - query
    direction-sent - direction
    datetime-2023-01-01t00-00-00 - datetime
    total-phone-bill-amount - amount)
  (:init
    (password-for venmo venmo-password)
    (search-query query-phone-bill)
    (search-direction direction-sent)
    (search-min-date datetime-2023-01-01t00-00-00))
  (:goal (and
    (found-total total-phone-bill-amount)
    (task-completed))))
