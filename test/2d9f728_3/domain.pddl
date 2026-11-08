(define (domain appworld-2d9f728-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship - object
  )
  (:constants
    supervisor phone venmo - app
    nancy roommate-a roommate-b - person
    amount-commute-share amount-dinner-share - amount
    note-commute note-dinner - note
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (roommate-relationship ?r - relationship)
    (roommates-found)
    (roommate ?p - person)
    (contact-email ?p - person ?e - email)
    (requested ?p - person)
    (paid ?p - person)
    (payment-request-sent ?p - person ?amt - amount ?n - note)
    (transaction-sent ?p - person ?amt - amount ?n - note)
    (task-completed)
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
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (roommate-relationship ?rel) (not (roommates-found)))
    :effect (roommates-found)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (roommates-found) (roommate ?p) (contact-email ?p ?e)
                       (not (requested ?p)))
    :effect (and (requested ?p) (payment-request-sent ?p ?amt ?n))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (roommates-found) (roommate ?p) (contact-email ?p ?e)
                       (not (paid ?p)))
    :effect (and (paid ?p) (transaction-sent ?p ?amt ?n))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (payment-request-sent nancy amount-commute-share note-commute)
                       (payment-request-sent roommate-a amount-commute-share note-commute)
                       (payment-request-sent roommate-b amount-commute-share note-commute)
                       (transaction-sent nancy amount-dinner-share note-dinner))
    :effect (task-completed)
  )
)
