(define (problem task-c77c005-2)
  (:domain appworld-c77c005-2)
  (:objects
    angelica-wilson - person
    angelica-wils-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    datetime-2023-05-01t00-00-00 - datetime
    direction-sent - direction
    payee-new payee-already-friend old-friend-1 old-friend-2 - person
    email-payee-new email-payee-already-friend email-old-friend-1 email-old-friend-2 - email)
  (:init
    (username-for venmo angelica-wils-at-gmail-com)
    (password-for venmo venmo-password)
    (month-start datetime-2023-05-01t00-00-00)
    (sent-direction direction-sent)
    (email-of payee-new email-payee-new)
    (email-of payee-already-friend email-payee-already-friend)
    (email-of old-friend-1 email-old-friend-1)
    (email-of old-friend-2 email-old-friend-2)
    (sent-money-this-month payee-new)
    (sent-money-this-month payee-already-friend)
    (friend payee-already-friend)
    (friend old-friend-1)
    (friend old-friend-2)
    (worklist-head payee-new)
    (worklist-next payee-new old-friend-1)
    (worklist-next old-friend-1 old-friend-2)
    (worklist-next old-friend-2 worklist-end))
  (:goal (and (worklist-head worklist-end) (task-completed))))
