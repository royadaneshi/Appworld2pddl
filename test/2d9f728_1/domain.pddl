(define (domain appworld-2d9f728-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship - object)
  (:constants
    phone venmo - app
    roommate - relationship)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contacts-searched ?r - relationship)
    (food-payer ?p - person)
    (taxi-note ?n - note)
    (food-note ?n - note)
    (taxi-share ?amt - amount)
    (food-share ?amt - amount)
    (payment-requested ?p - person ?n - note ?amt - amount)
    (payment-sent ?p - person ?n - note ?amt - amount)
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
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (contacts-searched ?r)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-searched roommate) (has-relationship ?p roommate) (contact-email ?p ?e) (not (payment-requested ?p ?n ?amt)) (not (task-completed)))
    :effect (and (payment-requested ?p ?n ?amt)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-searched roommate) (has-relationship ?p roommate) (contact-email ?p ?e) (not (payment-sent ?p ?n ?amt)) (not (task-completed)))
    :effect (and (payment-sent ?p ?n ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?fp - person ?tn - note ?fn - note ?ta - amount ?fa - amount)
    :precondition (and (has-relationship ?p1 roommate) (has-relationship ?p2 roommate) (not (= ?p1 ?p2)) (taxi-note ?tn) (taxi-share ?ta) (payment-requested ?p1 ?tn ?ta) (payment-requested ?p2 ?tn ?ta) (food-payer ?fp) (food-note ?fn) (food-share ?fa) (payment-sent ?fp ?fn ?fa) (not (task-completed)))
    :effect (and (task-completed)))
)
