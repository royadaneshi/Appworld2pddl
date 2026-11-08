(define (domain appworld-024c982-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount note privacy payment-request - object
  )
  (:constants
    venmo supervisor - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (request-to ?r - payment-request ?p - person)
    (request-amount ?r - payment-request ?amt - amount)
    (request-note ?r - payment-request ?n - note)
    (request-privacy ?r - payment-request ?pr - privacy)
    (request-created ?r - payment-request)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
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
    :effect (has-token venmo ?t)
  )

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and
      (has-token venmo ?t)
      (query-for ?p ?q)
      (email-of ?p ?e)
      (not (task-completed))
    )
    :effect (known-email ?p ?e)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?pr - privacy ?p - person ?r - payment-request)
    :precondition (and
      (has-token venmo ?t)
      (known-email ?p ?e)
      (request-to ?r ?p)
      (request-amount ?r ?amt)
      (request-note ?r ?n)
      (request-privacy ?r ?pr)
      (not (request-created ?r))
      (not (task-completed))
    )
    :effect (request-created ?r)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and
      (request-created ?r)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
