(define (domain appworld-f861c32-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship amount note payment-card count - object
    card-field - object)
  (:constants
    supervisor phone venmo - app
    coworker - relationship)
  (:predicates
    (credential-of-app ?a - app ?c - object)
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
    (task-completed)
    (venmo-cards-listed)
    (supervisor-cards-known)
    (card-details ?c - payment-card ?name ?owner ?number ?year ?month ?cvv - card-field))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t))
    :effect (contacts-found ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (balance-known))

  ; API: venmo.show_payment_cards  (shows that every saved card is expired)
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (venmo-cards-listed))


  ; API: supervisor.show_payment_cards
  (:action supervisor-show-payment-cards
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (supervisor-cards-known))

  ; API: venmo.add_payment_card  (a non-expired card of the supervisor that Venmo does not have yet)
  (:action venmo-add-payment-card
    :parameters (?name ?owner ?number ?year ?month ?cvv - card-field ?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (venmo-cards-listed) (supervisor-cards-known) (card-details ?c ?name ?owner ?number ?year ?month ?cvv) (not (known-id ?c)) (not (task-completed)))
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
