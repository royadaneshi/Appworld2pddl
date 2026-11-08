(define (domain appworld-270f1ff-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number relationship amount note privacy direction message transaction text-message - object)
  (:constants supervisor venmo phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (relation-of ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contact-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (last-birthday-gift ?p - person ?amt - amount)
    (found-last-gift ?p - person ?amt - amount)
    (double-of ?x - amount ?y - amount)
    (transaction-receiver ?tx - transaction ?p - person)
    (transaction-amount ?tx - transaction ?amt - amount)
    (transaction-note ?tx - transaction ?n - note)
    (transaction-privacy ?tx - transaction ?pv - privacy)
    (transaction-sent ?tx - transaction)
    (gift-sent ?p - person)
    (text-recipient ?msg - text-message ?p - person)
    (text-content ?msg - text-message ?m - message)
    (text-sent ?msg - text-message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email ?n - phone-number)
    :precondition (and (has-token phone ?t) (relation-of ?p ?r) (contact-email ?p ?e) (contact-phone ?p ?n) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-phone ?p ?n)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - direction ?p - person ?amt - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (last-birthday-gift ?p ?amt) (not (task-completed)))
    :effect (found-last-gift ?p ?amt))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?pv - privacy ?tx - transaction ?p - person ?last - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-last-gift ?p ?last) (double-of ?last ?amt) (transaction-receiver ?tx ?p) (transaction-amount ?tx ?amt) (transaction-note ?tx ?n) (transaction-privacy ?tx ?pv) (not (transaction-sent ?tx)) (not (task-completed)))
    :effect (and (transaction-sent ?tx) (gift-sent ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?msg - text-message ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (text-recipient ?msg ?p) (text-content ?msg ?m) (gift-sent ?p) (not (text-sent ?msg)) (not (task-completed)))
    :effect (text-sent ?msg))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction ?msg - text-message)
    :precondition (and (transaction-sent ?tx) (text-sent ?msg) (not (task-completed)))
    :effect (task-completed)))
