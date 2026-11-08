(define (domain appworld-21abae1-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token direction datetime amount - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (direction-sent ?d - direction)
    (month-start ?dt - datetime)
    (current-time ?dt - datetime)
    (sent-total-known ?amt - amount)
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
                       (username-for venmo ?u)
                       (password-for venmo ?pw)
                       (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?min - datetime ?max - datetime ?d - direction ?total - amount)
    :precondition (and (has-token venmo ?t)
                       (month-start ?min)
                       (current-time ?max)
                       (direction-sent ?d)
                       (not (task-completed)))
    :effect (sent-total-known ?total))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (sent-total-known ?ans)
                       (not (task-completed)))
    :effect (task-completed))
)
