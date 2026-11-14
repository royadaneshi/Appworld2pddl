(define (domain appworld-60d0b5b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount status description payment-request - object
  )
  (:constants supervisor phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (request-to ?r - payment-request ?p - person)
    (request-status ?r - payment-request ?s - status)
    (request-amount ?r - payment-request ?amt - amount)
    (found-request ?r - payment-request)
    (refunded ?r - payment-request)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?p ?q) (email-of ?p ?e)
                       (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status ?p - person ?e - email ?r - payment-request)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e)
                       (request-to ?r ?p) (request-status ?r ?s)
                       (not (task-completed)))
    :effect (and (found-request ?r))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person ?r - payment-request)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e)
                       (found-request ?r) (request-to ?r ?p) (request-amount ?r ?amt)
                       (not (refunded ?r)) (not (task-completed)))
    :effect (and (refunded ?r))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed))
  )
)
