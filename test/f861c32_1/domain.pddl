(define (domain appworld-f861c32-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship payment-card - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contacts-searched ?r - relationship)
    (balance-checked)
    (known-id ?c - payment-card)
    (refill-amount ?amt - amount)
    (balance-refilled)
    (task-amount ?amt - amount)
    (task-note ?n - note)
    (paid ?p - person ?amt - amount ?n - note)
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
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (balance-checked))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.add_to_venmo_balance
  (:action venmo-add-to-venmo-balance
    :parameters (?amt - amount ?c - payment-card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-checked) (known-id ?c) (refill-amount ?amt) (not (balance-refilled)) (not (task-completed)))
    :effect (balance-refilled))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (balance-refilled) (contacts-searched ?r) (has-relationship ?p ?r) (contact-email ?p ?e) (task-amount ?amt) (task-note ?d) (not (paid ?p ?amt ?d)) (not (task-completed)))
    :effect (paid ?p ?amt ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person ?amt - amount ?d - note)
    :precondition (and (balance-refilled) (task-amount ?amt) (task-note ?d) (paid ?p1 ?amt ?d) (paid ?p2 ?amt ?d) (paid ?p3 ?amt ?d) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (task-completed))
)
