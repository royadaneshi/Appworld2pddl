(define (problem task-afc0fce-2)
  (:domain appworld-afc0fce-2)
  (:objects
    robert friend-1 friend-2 - person
    username-7195945426 username-robertmartinez-at-gmail-com - username
    password-phone password-venmo - password
    token-phone token-venmo - token
    friend-1-email friend-2-email - email
    query-friend - query
    relationship-friend - relationship
    date-2023-05-26 - date
    direction-received - direction
  )
  (:init
    (password-for phone password-phone)
    (password-for venmo password-venmo)
    (username-for phone username-7195945426)
    (username-for venmo username-robertmartinez-at-gmail-com)
    (friend-email friend-1 friend-1-email)
    (friend-email friend-2 friend-2-email)
    (window-start date-2023-05-26)
    (received-from txn-1 friend-1)
    (received-from txn-2 friend-1)
    (received-from txn-3 friend-2)
  )
  (:goal (and
    (liked txn-1) (liked txn-2) (liked txn-3)
    (commented txn-1 comment-thanks)
    (commented txn-2 comment-thanks)
    (commented txn-3 comment-thanks)
    (task-completed)
  ))
)
