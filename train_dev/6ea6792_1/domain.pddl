(define (domain appworld-6ea6792-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship status payment-request - object
  )
  (:constants
    phone venmo - app
    req-from-roommate-1 req-from-roommate-2 req-from-roommate-3 req-from-roommate-4 req-from-roommate-5 req-from-roommate-6 req-from-roommate-7 req-from-roommate-8 req-from-roommate-9 req-from-roommate-10 - payment-request
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (target-relationship ?r - relationship)
    (query-for ?q - query ?r - relationship)
    (contacts-found ?r - relationship)
    (pending-status ?s - status)
    (pending-requests-listed)
    (pending ?pr - payment-request)
    (requested-by ?pr - payment-request ?p - person)
    (approved ?pr - payment-request)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw)
      (profile-known)
      (passwords-known)
      (username-for phone ?u)
      (password-for phone ?pw)
      (not (has-token phone ?t))
      (not (task-completed))
    )
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and
      (has-token phone ?t)
      (query-for ?q ?r)
      (target-relationship ?r)
      (not (task-completed))
    )
    :effect (and (contacts-found ?r))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw)
      (profile-known)
      (passwords-known)
      (username-for venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t))
      (not (task-completed))
    )
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and
      (has-token venmo ?t)
      (pending-status ?s)
      (not (task-completed))
    )
    :effect (and (pending-requests-listed))
  )

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?pr - payment-request ?t - token ?p - person ?r - relationship)
    :precondition (and
      (has-token venmo ?t)
      (pending-requests-listed)
      (pending ?pr)
      (requested-by ?pr ?p)
      (has-relationship ?p ?r)
      (target-relationship ?r)
      (contacts-found ?r)
      (not (approved ?pr))
      (not (task-completed))
    )
    :effect (and (approved ?pr))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (approved req-from-roommate-1)
      (approved req-from-roommate-2)
      (approved req-from-roommate-3)
      (approved req-from-roommate-4)
      (approved req-from-roommate-5)
      (approved req-from-roommate-6)
      (approved req-from-roommate-7)
      (approved req-from-roommate-8)
      (approved req-from-roommate-9)
      (approved req-from-roommate-10)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
