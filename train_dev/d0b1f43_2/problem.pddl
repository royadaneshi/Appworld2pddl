(define (problem task-d0b1f43-2)
  (:domain appworld-d0b1f43-2)
  (:objects
    paul-miller coworkers - person
    username-3379617841 paul-mill-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworkers - query
    relationship-coworkers - relationship
    coworker-emails - email
    date-2023-02-01 - date
    direction-received - direction
    total-received-amount - amount)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-3379617841)
    (username-for venmo paul-mill-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (contact-search query-coworkers relationship-coworkers coworkers)
    (contact-email coworkers coworker-emails)
    (target-group coworkers)
    (threshold-date date-2023-02-01)
    (target-direction direction-received)
    (total-for coworkers total-received-amount))
  (:goal (and (answer-found total-received-amount) (task-completed)))
)
