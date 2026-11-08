(define (domain appworld-024c982-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship amount note privacy payment-request - object
  )
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (search-query-for ?p - person ?q - query)
    (relation-of ?p - person ?rel - relationship)
    (known-email ?p - person ?e - email)
    (request-recipient ?r - payment-request ?p - person)
    (request-amount ?r - payment-request ?amt - amount)
    (request-note ?r - payment-request ?n - note)
    (request-privacy ?r - payment-request ?pv - privacy)
    (request-sent ?r - payment-request)
    (task-completed)
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
    :precondition (and
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
    :parameters (?t - token ?q - query ?rel - relationship ?p - person ?e - email)
    :precondition (and
      (has-token phone ?t)
      (search-query-for ?p ?q)
      (relation-of ?p ?rel)
      (not (task-completed))
    )
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t))
      (not (task-completed))
    )
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?pv - privacy ?r - payment-request ?p - person)
    :precondition (and
      (has-token venmo ?t)
      (known-email ?p ?e)
      (request-recipient ?r ?p)
      (request-amount ?r ?amt)
      (request-note ?r ?n)
      (request-privacy ?r ?pv)
      (not (request-sent ?r))
      (not (task-completed))
    )
    :effect (and (request-sent ?r))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and
      (request-sent ?r)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
