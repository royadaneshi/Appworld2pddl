(define (domain appworld-9dabbc9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship payment-request amount note - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?rel - relationship)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (identified ?p - person)
    (requested-by ?r - payment-request ?p - person)
    (corrected-amount ?r - payment-request ?a - amount)
    (correction-note ?n - note)
    (known-id ?r - payment-request)
    (amount-known ?r - payment-request)
    (denied ?r - payment-request)
    (transaction-sent ?p - person ?a - amount ?n - note)
    (task-completed))

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
    :parameters (?t - token ?rel - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?rel) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e) (identified ?p)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?r - payment-request ?p - person)
    :precondition (and (has-token venmo ?t) (identified ?p) (requested-by ?r ?p) (not (task-completed)))
    :effect (and (known-id ?r) (amount-known ?r)))

  ; API: venmo.deny_payment_request
  (:action venmo-deny-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?r) (not (denied ?r)) (not (task-completed)))
    :effect (denied ?r))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a - amount ?t - token ?n - note ?p - person ?r - payment-request)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (requested-by ?r ?p) (amount-known ?r) (corrected-amount ?r ?a) (correction-note ?n) (not (task-completed)))
    :effect (transaction-sent ?p ?a ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request ?p - person ?a - amount ?n - note)
    :precondition (and (denied ?r) (transaction-sent ?p ?a ?n) (not (task-completed)))
    :effect (task-completed)))
