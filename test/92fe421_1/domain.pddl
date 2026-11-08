(define (domain appworld-92fe421-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship datetime - object)
  (:constants amazon phone venmo supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (price-known)
    (roommates-known)
    (payments-checked)
    (roommate ?p - person)
    (email-of ?p - person ?e - email)
    (already-paid ?p - person)
    (share-amount ?amt - amount)
    (request-note ?n - note)
    (roommate-relationship ?r - relationship)
    (yesterday ?d - datetime)
    (request-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (price-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?r) (not (task-completed)))
    :effect (roommates-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - datetime)
    :precondition (and (has-token venmo ?t) (yesterday ?d) (not (task-completed)))
    :effect (payments-checked))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (has-token venmo ?t) (price-known) (roommates-known) (payments-checked) (roommate ?p) (email-of ?p ?e) (not (already-paid ?p)) (not (request-sent ?p)) (share-amount ?amt) (request-note ?n) (not (task-completed)))
    :effect (request-sent ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (request-sent ?p1) (request-sent ?p2) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (task-completed))
)
