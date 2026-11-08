(define (problem task-270f1ff-2)
  (:domain appworld-270f1ff-2)
  (:objects
    vickie daughter - person
    phone-username-8924356613 venmo-username-vicpowe-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    daughter-email - email
    daughter-phone-number - phone-number
    relationship-daughter - relationship
    amount-last-birthday amount-thrice-last-birthday - amount
    note-many-happy-returns-of-the-day - note
    private-true - privacy
    message-happy-birthday-daughter - message
    birthday-transaction - transaction)
  (:init
    (username-for phone phone-username-8924356613)
    (username-for venmo venmo-username-vicpowe-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relationship daughter relationship-daughter)
    (contact-email daughter daughter-email)
    (contact-phone daughter daughter-phone-number)
    (last-birthday-amount daughter amount-last-birthday)
    (thrice amount-last-birthday amount-thrice-last-birthday)
    (is-private private-true))
  (:goal (and
    (transaction-created birthday-transaction)
    (transaction-to birthday-transaction daughter)
    (transaction-amount birthday-transaction amount-thrice-last-birthday)
    (transaction-note birthday-transaction note-many-happy-returns-of-the-day)
    (transaction-privacy birthday-transaction private-true)
    (text-sent daughter message-happy-birthday-daughter)
    (task-completed)))
)
