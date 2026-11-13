(define (domain appworld-92fe421-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount description relationship query - object
  )
  (:constants
    supervisor phone spotify venmo - app
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (roommate ?p - person)
    (email-of ?p - person ?e - email)
    (roommate-relationship ?rel - relationship)
    (roommates-found)
    (premium-price-known)
    (share-amount ?amt - amount)
    (note-text ?d - description)
    (has-paid ?p - person)
    (payments-checked)
    (request-sent ?p - person)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?rel) (not (task-completed)))
    :effect (and (roommates-found))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_premium_subscriptions
  (:action spotify-show-premium-subscriptions
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (premium-price-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?q - query)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (payments-checked))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-found) (premium-price-known) (payments-checked)
                       (roommate ?p) (email-of ?p ?e) (share-amount ?amt) (note-text ?d)
                       (not (has-paid ?p)) (not (request-sent ?p)) (not (task-completed)))
    :effect (and (request-sent ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person)
    :precondition (and
      (request-sent ?p1)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
