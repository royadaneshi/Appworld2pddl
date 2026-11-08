(define (domain appworld-21abae1-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token datetime direction amount - object)
  (:constants
    venmo supervisor - app
    sent received - direction)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (month-start ?d - datetime)
    (now ?d - datetime)
    (transactions-retrieved ?dir - direction)
    (answer-amount ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for venmo ?u)
                       (password-for venmo ?pw)
                       (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?min - datetime ?max - datetime ?dir - direction)
    :precondition (and (has-token venmo ?t)
                       (month-start ?min)
                       (now ?max)
                       (not (task-completed)))
    :effect (and (transactions-retrieved ?dir)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (transactions-retrieved sent)
                       (transactions-retrieved received)
                       (answer-amount ?answer)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
