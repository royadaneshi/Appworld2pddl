(define (domain appworld-f861c32-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship card count - object)
  (:constants supervisor phone venmo - app zero - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (friend-relationship ?r - relationship)
    (is-friend ?p - person)
    (contact-email ?p - person ?e - email)
    (friends-searched)
    (balance-known)
    (known-id ?c - card)
    (refill-amount ?amt - amount)
    (balance-sufficient)
    (payment-amount ?amt - amount)
    (payment-note ?d - note)
    (sent ?p - person)
    (remaining-payments ?n - count)
    (decrement ?from - count ?to - count)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (login-username phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (friend-relationship ?r) (not (task-completed)))
    :effect (friends-searched))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (login-username venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (balance-known))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.add_to_venmo_balance
  (:action venmo-add-to-venmo-balance
    :parameters (?amt - amount ?c - card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-known) (known-id ?c) (refill-amount ?amt) (not (balance-sufficient)) (not (task-completed)))
    :effect (balance-sufficient))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person ?n1 - count ?n2 - count)
    :precondition (and (has-token venmo ?t) (friends-searched) (is-friend ?p) (contact-email ?p ?e) (payment-amount ?amt) (payment-note ?d) (balance-sufficient) (not (sent ?p)) (remaining-payments ?n1) (decrement ?n1 ?n2) (not (task-completed)))
    :effect (and (sent ?p) (not (remaining-payments ?n1)) (remaining-payments ?n2)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (remaining-payments zero) (not (task-completed)))
    :effect (task-completed)))
