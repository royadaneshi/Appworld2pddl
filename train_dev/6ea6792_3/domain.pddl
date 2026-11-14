(define (domain appworld-6ea6792-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query relationship status payment-request - object)
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (relationship-query ?r - relationship ?q - query)
    (target-relationship ?r - relationship)
    (contacts-searched ?r - relationship)
    (pending-filter ?s - status)
    (requests-listed)
    (pending-request ?pr - payment-request)
    (request-from ?pr - payment-request ?p - person)
    (approved ?pr - payment-request)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (relationship-query ?r ?q) (not (task-completed)))
    :effect (contacts-searched ?r)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (pending-filter ?s) (not (task-completed)))
    :effect (requests-listed)
  )

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?pr - payment-request ?t - token ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (requests-listed) (pending-request ?pr) (request-from ?pr ?p) (has-relationship ?p ?r) (target-relationship ?r) (contacts-searched ?r) (not (approved ?pr)) (not (task-completed)))
    :effect (approved ?pr)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed)
  )
)
