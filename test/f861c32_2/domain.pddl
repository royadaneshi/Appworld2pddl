(define (domain appworld-f861c32-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship amount note payment-card count - object)
  (:constants
    supervisor phone venmo - app
    coworker - relationship)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contacts-found ?r - relationship)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (balance-known)
    (known-id ?c - payment-card)
    (refill-amount ?amt - amount)
    (payment-amount ?amt - amount)
    (payment-note ?d - note)
    (balance-sufficient)
    (transaction-sent ?p - person ?amt - amount ?d - note)
    (paid ?p - person)
    (payments-made ?n - count)
    (succ ?n - count ?m - count)
    (required-payments ?n - count)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t))
    :effect (contacts-found ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (balance-known))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (known-id ?c))

  ; API: venmo.add_to_venmo_balance
  (:action venmo-add-to-venmo-balance
    :parameters (?amt - amount ?c - payment-card ?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (balance-known) (known-id ?c) (refill-amount ?amt) (not (balance-sufficient)))
    :effect (balance-sufficient))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person ?n - count ?m - count)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (balance-sufficient) (contacts-found coworker) (has-relationship ?p coworker) (email-of ?p ?e) (payment-amount ?amt) (payment-note ?d) (not (paid ?p)) (payments-made ?n) (succ ?n ?m))
    :effect (and (transaction-sent ?p ?amt ?d) (paid ?p) (not (payments-made ?n)) (payments-made ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - count)
    :precondition (and (not (task-completed)) (payments-made ?n) (required-payments ?n))
    :effect (task-completed))
)
