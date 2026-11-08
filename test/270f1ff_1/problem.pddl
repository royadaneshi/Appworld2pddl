(define (problem task-270f1ff-1)
  (:domain appworld-270f1ff-1)
  (:objects
    tracy-weber son - person
    tra-weber-at-gmail-com phone-7487389769 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    son-email - email
    son-phone-number - phone-number
    relationship-son - relationship
    amount-last-birthday-gift amount-twice-last-birthday-gift - amount
    note-happy-birthday - note
    private-true - privacy
    direction-sent - direction
    message-happy-birthday-son - message
    birthday-gift - transaction
    birthday-text - text-message)
  (:init
    (username-for venmo tra-weber-at-gmail-com)
    (username-for phone phone-7487389769)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (token-for venmo venmo-token)
    (token-for phone phone-token)
    (relation-of son relationship-son)
    (contact-email son son-email)
    (contact-phone son son-phone-number)
    (last-birthday-gift son amount-last-birthday-gift)
    (double-of amount-last-birthday-gift amount-twice-last-birthday-gift)
    (transaction-receiver birthday-gift son)
    (transaction-amount birthday-gift amount-twice-last-birthday-gift)
    (transaction-note birthday-gift note-happy-birthday)
    (transaction-privacy birthday-gift private-true)
    (text-recipient birthday-text son)
    (text-content birthday-text message-happy-birthday-son))
  (:goal (and (transaction-sent birthday-gift) (text-sent birthday-text) (task-completed))))
