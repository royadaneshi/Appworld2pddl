(define (domain appworld-9ef798c-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query payment-request - object)
  (:constants supervisor venmo phone - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for-person ?q - query ?p - person)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (request-from ?r - payment-request ?p - person)
    (query-for-request ?q - query ?r - payment-request)
    (known-id ?r - payment-request)
    (approved ?r - payment-request)
    (target-request ?r - payment-request)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for-person ?q ?p) (contact-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?q - query ?p - person ?e - email ?r - payment-request)
    :precondition (and (has-token venmo ?t) (query-for-request ?q ?r) (known-email ?p ?e) (request-from ?r ?p) (not (task-completed)))
    :effect (known-id ?r))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?r) (not (approved ?r)) (not (task-completed)))
    :effect (approved ?r))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and (target-request ?r) (approved ?r) (not (task-completed)))
    :effect (task-completed)))
