(define (domain appworld-270f1ff-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number relationship direction datetime amount note privacy message - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (birthday-window ?p - person ?dmin - datetime ?dmax - datetime)
    (found-last-gift-amount ?p - person ?a - amount)
    (four-times ?a4 - amount ?a - amount)
    (birthday-gift-sent ?p - person)
    (transaction-sent ?p - person ?a - amount ?n - note ?pr - privacy)
    (text-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email ?ph - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-phone ?p ?ph)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?dir - direction ?dmin - datetime ?dmax - datetime ?p - person ?a - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (birthday-window ?p ?dmin ?dmax) (not (task-completed)))
    :effect (and (found-last-gift-amount ?p ?a)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a4 - amount ?t - token ?n - note ?pr - privacy ?p - person ?a - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-last-gift-amount ?p ?a) (four-times ?a4 ?a) (not (birthday-gift-sent ?p)) (not (task-completed)))
    :effect (and (transaction-sent ?p ?a4 ?n ?pr) (birthday-gift-sent ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (birthday-gift-sent ?p) (not (text-sent ?p ?m)) (not (task-completed)))
    :effect (and (text-sent ?p ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?a - amount ?n - note ?pr - privacy ?m - message)
    :precondition (and (transaction-sent ?p ?a ?n ?pr) (text-sent ?p ?m) (not (task-completed)))
    :effect (and (task-completed)))
)
