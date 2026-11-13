(define (problem task-4fab96f-3)
  (:domain appworld-4fab96f-3)
  (:objects
    phone-number-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
    jennifer-powell roommate-1 roommate-2 roommate-3 - person
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-number-4288705164)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (roommate-relationship relationship-roommates)
    (search-query-for query-roommates relationship-roommates)
    (pending-status status-pending)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate roommate-3)
    (sent-to stale-request-roommate-1 roommate-2)
    (sent-to stale-request-roommate-2 roommate-3)
    (sent-to stale-request-roommate-3 roommate-2)
    (sent-to stale-request-roommate-4 roommate-2)
    (sent-to stale-request-roommate-5 roommate-2)
    (sent-to stale-request-roommate-6 roommate-3)
    (pending stale-request-roommate-1)
    (pending stale-request-roommate-2)
    (pending stale-request-roommate-3)
    (pending stale-request-roommate-4)
    (pending stale-request-roommate-5)
    (pending stale-request-roommate-6)
    (at-least-50-days-old stale-request-roommate-1)
    (at-least-50-days-old stale-request-roommate-2)
    (at-least-50-days-old stale-request-roommate-3)
    (at-least-50-days-old stale-request-roommate-4)
    (at-least-50-days-old stale-request-roommate-5)
    (at-least-50-days-old stale-request-roommate-6))
  (:goal (and
    (reminded stale-request-roommate-1)
    (reminded stale-request-roommate-2)
    (reminded stale-request-roommate-3)
    (reminded stale-request-roommate-4)
    (reminded stale-request-roommate-5)
    (reminded stale-request-roommate-6)
    (task-completed)))
)
