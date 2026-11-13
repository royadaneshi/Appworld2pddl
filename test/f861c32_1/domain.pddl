(define (domain appworld-f861c32-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship payment-card - object
    card-field - object)
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (balance-checked))

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
