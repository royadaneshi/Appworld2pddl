(define (domain appworld-166f4ff-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token amount - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (account-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (found-requested-total ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for venmo ?pw)
                       (account-username venmo ?u)
                       (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token venmo ?t)
                       (not (task-completed)))
    :effect (found-requested-total ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (found-requested-total ?amt)
                       (not (task-completed)))
    :effect (task-completed)))
