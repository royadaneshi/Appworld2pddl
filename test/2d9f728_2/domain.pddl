(define (domain appworld-2d9f728-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (roommate-relationship ?r - relationship)
    (is-roommate ?p - person)
    (food-payer ?p - person)
    (email-of ?p - person ?e - email)
    (roommates-found)
    (taxi-share ?amt - amount)
    (food-share ?amt - amount)
    (taxi-note ?n - note)
    (food-note ?n - note)
    (taxi-requested ?p - person)
    (dinner-paid ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?r) (not (task-completed)))
    :effect (and (roommates-found)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-found) (is-roommate ?p) (email-of ?p ?e) (taxi-share ?amt) (taxi-note ?d) (not (taxi-requested ?p)) (not (task-completed)))
    :effect (and (taxi-requested ?p)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-found) (food-payer ?p) (email-of ?p ?e) (food-share ?amt) (food-note ?d) (not (dinner-paid ?p)) (not (task-completed)))
    :effect (and (dinner-paid ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?payer - person ?other - person)
    :precondition (and (food-payer ?payer) (is-roommate ?payer) (is-roommate ?other) (not (= ?payer ?other)) (taxi-requested ?payer) (taxi-requested ?other) (dinner-paid ?payer) (not (task-completed)))
    :effect (and (task-completed)))
)
