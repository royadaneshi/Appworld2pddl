(define (problem task-4fab96f-3)
  (:domain appworld-4fab96f-3)
  (:objects
    phone-number-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommates - query
    relationship-roommates - relationship
    status-pending - status
    jennifer-powell roommate-connor-brown roommate-edwin-wilson roommate-martin-blackburn - person
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
    (roommate roommate-connor-brown)
    (roommate roommate-edwin-wilson)
    (roommate roommate-martin-blackburn)
    (sent-to request-1608 roommate-edwin-wilson)
    (sent-to request-1627 roommate-martin-blackburn)
    (sent-to request-1615 roommate-edwin-wilson)
    (sent-to request-1613 roommate-edwin-wilson)
    (sent-to request-1612 roommate-edwin-wilson)
    (sent-to request-1624 roommate-martin-blackburn)
    (pending request-1608)
    (pending request-1627)
    (pending request-1615)
    (pending request-1613)
    (pending request-1612)
    (pending request-1624)
    (at-least-50-days-old request-1608)
    (at-least-50-days-old request-1627)
    (at-least-50-days-old request-1615)
    (at-least-50-days-old request-1613)
    (at-least-50-days-old request-1612)
    (at-least-50-days-old request-1624))
  (:goal (and
    (reminded request-1608)
    (reminded request-1627)
    (reminded request-1615)
    (reminded request-1613)
    (reminded request-1612)
    (reminded request-1624)
    (task-completed)))
)
