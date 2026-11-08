(define (domain appworld-d18139b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person payment-request username password token relationship status - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (roommate ?p - person)
    (roommates-known)
    (request-from ?r - payment-request ?p - person)
    (request-this-month ?r - payment-request)
    (request-pending ?r - payment-request)
    (requests-known)
    (approved ?r - payment-request)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (roommates-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (requests-known))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-known) (requests-known)
                       (roommate ?p) (request-from ?r ?p) (request-this-month ?r)
                       (request-pending ?r) (not (task-completed)))
    :effect (and (approved ?r) (not (request-pending ?r))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r1 ?r2 ?r3 - payment-request)
    :precondition (and (approved ?r1) (approved ?r2) (approved ?r3)
                       (not (= ?r1 ?r2)) (not (= ?r1 ?r3)) (not (= ?r2 ?r3))
                       (not (task-completed)))
    :effect (task-completed))
)
