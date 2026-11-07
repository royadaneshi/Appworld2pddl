(define (domain appworld-60d0b5b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount status payment-request description - object
  )
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (approved-status ?s - status)
    (last-approved-request ?r - payment-request ?p - person)
    (request-amount ?r - payment-request ?amt - amount)
    (found-request ?r - payment-request ?p - person ?amt - amount)
    (refund-description ?d - description)
    (refunded ?r - payment-request ?p - person ?amt - amount)
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
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status ?p - person ?e - email ?r - payment-request ?amt - amount)
    :precondition (and (has-token venmo ?t) (approved-status ?s) (known-email ?p ?e) (last-approved-request ?r ?p) (request-amount ?r ?amt) (not (task-completed)))
    :effect (and (found-request ?r ?p ?amt))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person ?r - payment-request)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-request ?r ?p ?amt) (refund-description ?d) (not (refunded ?r ?p ?amt)) (not (task-completed)))
    :effect (and (refunded ?r ?p ?amt))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request ?p - person ?amt - amount)
    :precondition (and (refunded ?r ?p ?amt) (not (task-completed)))
    :effect (and (task-completed))
  )
)
