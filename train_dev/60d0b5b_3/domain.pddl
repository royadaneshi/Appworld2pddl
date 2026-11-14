(define (domain appworld-60d0b5b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query status description amount payment-request - object
  )
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (profile-known)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (approved-status ?s - status)
    (refund-description ?d - description)
    (latest-approved-request ?p - person ?r - payment-request)
    (request-amount ?r - payment-request ?amt - amount)
    (found-request ?r - payment-request)
    (refund-amount-known ?p - person ?amt - amount)
    (transaction-sent ?p - person ?amt - amount)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)) (not (profile-known)))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (login-username phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (contact-query ?p ?q) (email-of ?p ?e)
                       (not (known-email ?p ?e)))
    :effect (known-email ?p ?e)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (login-username venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status ?p - person ?e - email ?r - payment-request ?amt - amount)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (approved-status ?s)
                       (known-email ?p ?e) (latest-approved-request ?p ?r) (request-amount ?r ?amt)
                       (not (found-request ?r)))
    :effect (and (found-request ?r) (refund-amount-known ?p ?amt))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (refund-description ?d)
                       (known-email ?p ?e) (refund-amount-known ?p ?amt)
                       (not (transaction-sent ?p ?amt)))
    :effect (transaction-sent ?p ?amt)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed)
  )
)
