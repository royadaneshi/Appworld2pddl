(define (domain appworld-024c982-3)
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
    (friend ?p - person)
    (email-of ?p - person ?e - email)
    (query-for ?q - query ?p - person)
    (known-email ?p - person ?e - email)
    (request-target ?r - payment-request ?p - person)
    (request-amount ?r - payment-request ?m - amount)
    (request-note ?r - payment-request ?n - note)
    (request-privacy ?r - payment-request ?v - privacy)
    (request-created ?r - payment-request)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
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

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and
      (has-token venmo ?t)
      (query-for ?q ?p)
      (friend ?p)
      (email-of ?p ?e)
      (not (task-completed))
    )
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?m - amount ?t - token ?n - note ?v - privacy ?r - payment-request ?p - person)
    :precondition (and
      (has-token venmo ?t)
      (known-email ?p ?e)
      (request-target ?r ?p)
      (request-amount ?r ?m)
      (request-note ?r ?n)
      (request-privacy ?r ?v)
      (not (request-created ?r))
      (not (task-completed))
    )
    :effect (and (request-created ?r))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and
      (request-created ?r)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
