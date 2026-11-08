(define (domain appworld-90adc3f-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person payment-request username password token email amount description privacy - object)
  (:constants supervisor venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (requests-listed)
    (sent-yesterday-evening ?r - payment-request)
    (request-to ?r - payment-request ?p - person)
    (email-of ?p - person ?e - email)
    (request-amount ?r - payment-request ?amt - amount)
    (request-description ?r - payment-request ?d - description)
    (request-privacy ?r - payment-request ?pv - privacy)
    (minus-five ?old - amount ?new - amount)
    (deleted ?r - payment-request)
    (recreated ?r - payment-request)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (requests-listed))

  ; API: venmo.delete_payment_request
  (:action venmo-delete-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (requests-listed) (sent-yesterday-evening ?r) (not (deleted ?r)) (not (task-completed)))
    :effect (deleted ?r))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?pv - privacy ?r - payment-request ?p - person ?old - amount)
    :precondition (and (has-token venmo ?t) (requests-listed) (sent-yesterday-evening ?r) (request-to ?r ?p) (email-of ?p ?e) (request-amount ?r ?old) (minus-five ?old ?amt) (request-description ?r ?d) (request-privacy ?r ?pv) (not (recreated ?r)) (not (task-completed)))
    :effect (recreated ?r))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r1 - payment-request ?r2 - payment-request)
    :precondition (and (not (= ?r1 ?r2)) (deleted ?r1) (recreated ?r1) (deleted ?r2) (recreated ?r2) (not (task-completed)))
    :effect (task-completed))
)
