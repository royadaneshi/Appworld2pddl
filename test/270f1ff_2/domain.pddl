(define (domain appworld-270f1ff-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number relationship amount note privacy message transaction - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contact-phone ?p - person ?ph - phone-number)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (last-birthday-amount ?p - person ?a - amount)
    (found-last-birthday-amount ?p - person ?a - amount)
    (thrice ?base - amount ?a - amount)
    (is-private ?pv - privacy)
    (transaction-created ?tx - transaction)
    (transaction-to ?tx - transaction ?p - person)
    (transaction-amount ?tx - transaction ?a - amount)
    (transaction-note ?tx - transaction ?d - note)
    (transaction-privacy ?tx - transaction ?pv - privacy)
    (venmo-sent ?p - person)
    (text-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email ?ph - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (contact-email ?p ?e) (contact-phone ?p ?ph) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-phone ?p ?ph)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?p - person ?a - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (last-birthday-amount ?p ?a) (not (task-completed)))
    :effect (found-last-birthday-amount ?p ?a))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a - amount ?t - token ?d - note ?pv - privacy ?p - person ?base - amount ?tx - transaction)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-last-birthday-amount ?p ?base) (thrice ?base ?a) (is-private ?pv) (not (transaction-created ?tx)) (not (task-completed)))
    :effect (and (transaction-created ?tx) (transaction-to ?tx ?p) (transaction-amount ?tx ?a) (transaction-note ?tx ?d) (transaction-privacy ?tx ?pv) (venmo-sent ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (venmo-sent ?p) (not (task-completed)))
    :effect (text-sent ?p ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction ?p - person ?a - amount ?d - note ?pv - privacy ?m - message)
    :precondition (and (transaction-created ?tx) (transaction-to ?tx ?p) (transaction-amount ?tx ?a) (transaction-note ?tx ?d) (transaction-privacy ?tx ?pv) (text-sent ?p ?m) (not (task-completed)))
    :effect (task-completed))
)
