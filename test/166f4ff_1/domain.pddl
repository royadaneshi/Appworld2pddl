(define (domain appworld-166f4ff-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token amount - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (found-requested-total ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (found-requested-total ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (found-requested-total ?amt) (not (task-completed)))
    :effect (and (task-completed)))
)
