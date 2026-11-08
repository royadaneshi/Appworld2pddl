(define (problem task-552869a-3)
  (:domain appworld-552869a-3)
  (:objects
    martin - person
    mar-blac-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    query-internet-bill - query
    datetime-2023-01-01 datetime-2023-05-18 - datetime
    direction-sent - direction
    total-internet-bill-paid - amount)
  (:init
    (username-for venmo mar-blac-at-gmail-com)
    (password-for venmo venmo-password)
    (bill-query query-internet-bill)
    (year-start datetime-2023-01-01)
    (current-time datetime-2023-05-18)
    (sent-direction direction-sent)
    (total-paid-for query-internet-bill total-internet-bill-paid))
  (:goal (and (found-total total-internet-bill-paid)
              (task-completed))))
