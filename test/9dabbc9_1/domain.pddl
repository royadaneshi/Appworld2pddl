(define (domain appworld-9dabbc9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship payment-request amount note - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?rel - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (requested-by ?r - payment-request ?p - person)
    (amount-of ?r - payment-request ?a - amount)
    (known-id ?r - payment-request)
    (known-amount ?r - payment-request ?a - amount)
    (increased-by-5-percent ?orig - amount ?new - amount)
    (denied ?r - payment-request)
    (sent ?p - person ?a - amount ?n - note)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?rel) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?r - payment-request ?p - person ?e - email ?a - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (requested-by ?r ?p) (amount-of ?r ?a) (not (task-completed)))
    :effect (and (known-id ?r) (known-amount ?r ?a)))

  ; API: venmo.deny_payment_request
  (:action venmo-deny-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?r) (not (denied ?r)) (not (task-completed)))
    :effect (and (denied ?r)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a - amount ?t - token ?n - note ?p - person ?r - payment-request ?orig - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (requested-by ?r ?p) (known-amount ?r ?orig) (increased-by-5-percent ?orig ?a) (not (sent ?p ?a ?n)) (not (task-completed)))
    :effect (and (sent ?p ?a ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request ?p - person ?a - amount ?n - note)
    :precondition (and (denied ?r) (sent ?p ?a ?n) (requested-by ?r ?p) (not (task-completed)))
    :effect (and (task-completed))))
