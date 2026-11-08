(define (domain appworld-92fe421-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token email amount description relationship query - object)
  (:constants amazon phone venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (roommate ?p - person)
    (contact-email ?p - person ?e - email)
    (already-paid ?p - person)
    (share-amount ?amt - amount)
    (request-description ?d - description)
    (roommate-relationship ?r - relationship)
    (payment-query ?q - query)
    (prime-cost-known)
    (roommates-known)
    (payments-checked)
    (request-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (prime-cost-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?r) (not (task-completed)))
    :effect (and (roommates-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?q - query)
    :precondition (and (has-token venmo ?t) (payment-query ?q) (not (task-completed)))
    :effect (and (payments-checked)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (roommate ?p) (contact-email ?p ?e) (roommates-known) (prime-cost-known) (payments-checked) (share-amount ?amt) (request-description ?d) (not (already-paid ?p)) (not (request-sent ?p)) (not (task-completed)))
    :effect (and (request-sent ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (request-sent ?p1) (request-sent ?p2) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (and (task-completed))))
