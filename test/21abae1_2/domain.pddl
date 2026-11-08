(define (domain appworld-21abae1-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token amount datetime direction - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (month-start ?d - datetime)
    (received-direction ?dir - direction)
    (found-received-total ?amt - amount)
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
    :parameters (?t - token ?min - datetime ?dir - direction ?amt - amount)
    :precondition (and (has-token venmo ?t)
                       (month-start ?min)
                       (received-direction ?dir)
                       (not (task-completed)))
    :effect (found-received-total ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (found-received-total ?ans)
                       (not (task-completed)))
    :effect (task-completed)))
