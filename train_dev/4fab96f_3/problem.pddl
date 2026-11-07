(define (problem task-4fab96f-3)
  (:domain appworld-4fab96f-3)
  (:objects
    jennifer-powell roommate-1 roommate-2 friend-1 - person
    phone-number-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
  )
  (:init
    (username-for phone phone-number-4288705164)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate-relationship relationship-roommates)
    (search-query-for query-roommates relationship-roommates)
    (pending-status status-pending)
    (roommate roommate-1)
    (roommate roommate-2)
    (sent-to stale-request-roommate-1 roommate-1)
    (sent-to stale-request-roommate-2 roommate-2)
    (sent-to recent-request-roommate-1 roommate-1)
    (sent-to stale-request-friend friend-1)
    (pending stale-request-roommate-1)
    (pending stale-request-roommate-2)
    (pending recent-request-roommate-1)
    (pending stale-request-friend)
    (at-least-50-days-old stale-request-roommate-1)
    (at-least-50-days-old stale-request-roommate-2)
    (at-least-50-days-old stale-request-friend)
  )
  (:goal (and
    (reminded stale-request-roommate-1)
    (reminded stale-request-roommate-2)
    (not (reminded recent-request-roommate-1))
    (not (reminded stale-request-friend))
    (task-completed)
  ))
)
