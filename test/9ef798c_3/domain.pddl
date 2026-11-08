(define (domain appworld-9ef798c-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query payment-request - object
  )
  (:constants supervisor venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?r - payment-request)
    (request-from ?r - payment-request ?p - person)
    (request-matches ?r - payment-request ?q - query)
    (request-pending ?r - payment-request)
    (approved ?r - payment-request)
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
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?q - query ?r - payment-request)
    :precondition (and (has-token venmo ?t) (request-matches ?r ?q) (not (task-completed)))
    :effect (and (known-id ?r))
  )

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?r) (request-pending ?r) (not (approved ?r)) (not (task-completed)))
    :effect (and (approved ?r) (not (request-pending ?r)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and (approved ?r) (not (task-completed)))
    :effect (and (task-completed))
  )
)
