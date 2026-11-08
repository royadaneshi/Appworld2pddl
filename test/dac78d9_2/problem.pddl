(define (problem task-dac78d9-2)
  (:domain appworld-dac78d9-2)
  (:objects
    ashley-moore - person
    as-moore-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    friend-count-since-2022-10-01 - count)
  (:init
    (account-username venmo as-moore-at-gmail-com)
    (password-for venmo venmo-password))
  (:goal (and (found-friend-count friend-count-since-2022-10-01) (task-completed))))
