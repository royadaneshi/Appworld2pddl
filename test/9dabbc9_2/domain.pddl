(define (domain appworld-9dabbc9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship payment-request amount note - object
  )
  (:constants supervisor phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (requested-by ?pr - payment-request ?p - person)
    (request-amount ?pr - payment-request ?a - amount)
    (ten-percent-less ?reduced - amount ?original - amount)
    (rent-decrease-note ?n - note)
    (known-id ?pr - payment-request)
    (corrected-amount ?pr - payment-request ?a - amount)
    (denied ?pr - payment-request)
    (transaction-sent ?p - person ?a - amount ?n - note)
    (task-completed)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u)
      (passwords-known)
      (username-for phone ?u)
      (password-for phone ?pw)
      (not (has-token phone ?t))
      (not (task-completed))
    )
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and
      (has-token phone ?t)
      (has-relationship ?p ?r)
      (email-of ?p ?e)
      (not (task-completed))
    )
    :effect (known-email ?p ?e)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u)
      (passwords-known)
      (username-for venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t))
      (not (task-completed))
    )
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?p - person ?e - email ?pr - payment-request ?ra - amount ?ca - amount)
    :precondition (and
      (has-token venmo ?t)
      (known-email ?p ?e)
      (requested-by ?pr ?p)
      (request-amount ?pr ?ra)
      (ten-percent-less ?ca ?ra)
      (not (task-completed))
    )
    :effect (and
      (known-id ?pr)
      (corrected-amount ?pr ?ca)
    )
  )

  ; API: venmo.deny_payment_request
  (:action venmo-deny-payment-request
    :parameters (?pr - payment-request ?t - token)
    :precondition (and
      (has-token venmo ?t)
      (known-id ?pr)
      (not (denied ?pr))
      (not (task-completed))
    )
    :effect (denied ?pr)
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?a - amount ?t - token ?n - note ?p - person ?pr - payment-request)
    :precondition (and
      (has-token venmo ?t)
      (known-email ?p ?e)
      (requested-by ?pr ?p)
      (known-id ?pr)
      (corrected-amount ?pr ?a)
      (rent-decrease-note ?n)
      (not (transaction-sent ?p ?a ?n))
      (not (task-completed))
    )
    :effect (transaction-sent ?p ?a ?n)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pr - payment-request ?p - person ?a - amount ?n - note)
    :precondition (and
      (denied ?pr)
      (transaction-sent ?p ?a ?n)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
