(define (problem task-c77c005-1)
  (:domain appworld-c77c005-1)
  (:objects
    glenn-burton - person
    glenn-burton-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    datetime-2023-05-01t00-00-00 - datetime
    email-recent-payee-1 email-recent-payee-2 email-stale-friend-1 email-kept-friend-1 - email)
  (:init
    (password-for venmo venmo-password)
    (month-start datetime-2023-05-01t00-00-00)
    (email-of recent-payee-1 email-recent-payee-1)
    (email-of recent-payee-2 email-recent-payee-2)
    (email-of stale-friend-1 email-stale-friend-1)
    (email-of kept-friend-1 email-kept-friend-1)
    (transacted-this-month recent-payee-1)
    (transacted-this-month recent-payee-2)
    (transacted-this-month kept-friend-1)
    (is-friend stale-friend-1)
    (is-friend kept-friend-1))
  (:goal (and
    (is-friend recent-payee-1)
    (is-friend recent-payee-2)
    (is-friend kept-friend-1)
    (not (is-friend stale-friend-1))
    (task-completed))))
