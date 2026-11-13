(define (problem task-fdc4b74-3)
  (:domain appworld-fdc4b74-3)
  (:objects
    cory-wilson manager - person
    corwils-at-gmail-com - username
    gmail-password - password
    gmail-token - token
    query-camping query-item-1 query-item-2 query-item-3 query-item-4 query-item-5 query-item-6 query-item-7 - query
    draft-camping - draft
    item-1 item-2 item-3 item-4 item-5 item-6 item-7 - item
    body-with-prices - body
    c0 c1 c2 c3 c4 c5 c6 c7 - count
  )
  (:init
    (username-for gmail corwils-at-gmail-com)
    (password-for gmail gmail-password)
    (draft-matches query-camping draft-camping)
    (draft-recipient draft-camping manager)
    (item-in-draft draft-camping item-1)
    (item-in-draft draft-camping item-2)
    (item-in-draft draft-camping item-3)
    (item-in-draft draft-camping item-4)
    (item-in-draft draft-camping item-5)
    (item-in-draft draft-camping item-6)
    (item-in-draft draft-camping item-7)
    (item-query item-1 query-item-1)
    (item-query item-2 query-item-2)
    (item-query item-3 query-item-3)
    (item-query item-4 query-item-4)
    (item-query item-5 query-item-5)
    (item-query item-6 query-item-6)
    (item-query item-7 query-item-7)
    (body-for body-with-prices draft-camping)
    (prices-found c0)
    (succ c0 c1)
    (succ c1 c2)
    (succ c2 c3)
    (succ c3 c4)
    (succ c4 c5)
    (succ c5 c6)
    (succ c6 c7)
    (num-items c7))
  (:goal (and
    (draft-updated draft-camping)
    (email-sent draft-camping)
    (task-completed))))
