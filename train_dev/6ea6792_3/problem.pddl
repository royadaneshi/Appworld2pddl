(define (problem task-6ea6792-3)
  (:domain appworld-6ea6792-3)
  (:objects
    paul contact-coworker contact-friend contact-sibling - person
    phone-username-3379617841 venmo-username-paul-mill-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker query-friend - query
    coworker friend sibling - relationship
    status-pending - status
    pr-from-coworker pr-from-friend pr-from-sibling - payment-request
  )
  (:init
    (username-for phone phone-username-3379617841)
    (username-for venmo venmo-username-paul-mill-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship contact-coworker coworker)
    (has-relationship contact-friend friend)
    (has-relationship contact-sibling sibling)
    (relationship-query coworker query-coworker)
    (relationship-query friend query-friend)
    (target-relationship coworker)
    (target-relationship friend)
    (pending-filter status-pending)
    (pending-request pr-from-coworker)
    (pending-request pr-from-friend)
    (pending-request pr-from-sibling)
    (request-from pr-from-coworker contact-coworker)
    (request-from pr-from-friend contact-friend)
    (request-from pr-from-sibling contact-sibling)
  )
  (:goal (and
    (approved pr-from-coworker)
    (approved pr-from-friend)
    (task-completed)
  ))
)
