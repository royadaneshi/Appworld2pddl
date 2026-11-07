(define (problem task-4fab96f-2)
  (:domain appworld-4fab96f-2)
  (:objects
    kiara coworker-1 coworker-2 friend-1 - person
    kia-bailey-at-gmail-com phone-8909828624 - username
    pw-phone pw-venmo - password
    tok-phone tok-venmo - token
    query-coworkers - query
    rel-coworkers - relationship
    status-pending - status
    pr-coworker-1-recent pr-friend-1-old - payment-request)
  (:init
    (username-for phone phone-8909828624)
    (username-for venmo kia-bailey-at-gmail-com)
    (password-for phone pw-phone)
    (password-for venmo pw-venmo)
    (coworker-query query-coworkers)
    (coworker-relationship rel-coworkers)
    (pending-filter status-pending)
    (coworker coworker-1)
    (coworker coworker-2)
    (request-to pr-coworker-1-old coworker-1)
    (request-to pr-coworker-2-old coworker-2)
    (request-to pr-coworker-1-recent coworker-1)
    (request-to pr-friend-1-old friend-1)
    (request-pending pr-coworker-1-old)
    (request-pending pr-coworker-2-old)
    (request-pending pr-coworker-1-recent)
    (request-pending pr-friend-1-old)
    (request-at-least-40-days-old pr-coworker-1-old)
    (request-at-least-40-days-old pr-coworker-2-old)
    (request-at-least-40-days-old pr-friend-1-old))
  (:goal (and (reminded pr-coworker-1-old)
              (reminded pr-coworker-2-old)
              (task-completed)))
)
