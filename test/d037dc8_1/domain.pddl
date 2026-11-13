(define (domain appworld-d037dc8-1)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token email relationship amount description - object
  )
  (:constants amazon venmo phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (roommate ?p - person)
    (email-of ?p - person ?e - email)
    (roommate-relationship ?rel - relationship)
    (roommates-found)
    (orders-found)
    (share-amount ?amt - amount)
    (request-note ?d - description)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?rel) (not (task-completed)))
    :effect (and (roommates-found))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (orders-found))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-found) (orders-found) (roommate ?p) (email-of ?p ?e) (share-amount ?amt) (request-note ?d) (not (request-sent ?p)) (not (task-completed)))
    :effect (and (request-sent ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?p - person) (imply (roommate ?p) (request-sent ?p))) (not (task-completed)))
    :effect (task-completed))

)
