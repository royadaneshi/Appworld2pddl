(define (domain appworld-d18139b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person payment-request username password token relationship status - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (roommate-relationship ?rel - relationship)
    (pending-status ?s - status)
    (is-roommate ?p - person)
    (sent-by ?r - payment-request ?p - person)
    (created-this-month ?r - payment-request)
    (pending ?r - payment-request)
    (roommates-found)
    (received-requests-found)
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
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (roommate-relationship ?rel))
    :effect (roommates-found))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (pending-status ?s))
    :effect (received-requests-found))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (roommates-found) (received-requests-found) (sent-by ?r ?p) (is-roommate ?p) (created-this-month ?r) (pending ?r) (not (approved ?r)))
    :effect (and (approved ?r) (not (pending ?r))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r1 ?r2 ?r3 - payment-request)
    :precondition (and (not (task-completed)) (approved ?r1) (approved ?r2) (approved ?r3) (not (= ?r1 ?r2)) (not (= ?r1 ?r3)) (not (= ?r2 ?r3)))
    :effect (task-completed))
)
