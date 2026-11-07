(define (problem task-6ea6792-1)
  (:domain appworld-6ea6792-1)
  (:objects
    nancy-ritter roommate-sender coworker-sender friend-sender - person
    phone-2307354647 nan-ritt-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-roommate query-coworker - query
    roommate coworker friend - relationship
    status-pending - status
    req-from-friend - payment-request
  )
  (:init
    (username-for phone phone-2307354647)
    (username-for venmo nan-ritt-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-roommate roommate)
    (query-for query-coworker coworker)
    (target-relationship roommate)
    (target-relationship coworker)
    (pending-status status-pending)
    (has-relationship roommate-sender roommate)
    (has-relationship coworker-sender coworker)
    (has-relationship friend-sender friend)
    (pending req-from-roommate)
    (pending req-from-coworker)
    (pending req-from-friend)
    (requested-by req-from-roommate roommate-sender)
    (requested-by req-from-coworker coworker-sender)
    (requested-by req-from-friend friend-sender)
  )
  (:goal (and
    (approved req-from-roommate)
    (approved req-from-coworker)
    (task-completed)
  ))
)
