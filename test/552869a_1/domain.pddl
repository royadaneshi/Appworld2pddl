(define (domain appworld-552869a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query direction datetime amount - object)
  (:constants
    venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (search-query ?q - query)
    (search-direction ?d - direction)
    (search-min-date ?dt - datetime)
    (found-total ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?q - query ?min - datetime ?d - direction ?amt - amount)
    :precondition (and (has-token venmo ?t) (search-query ?q) (search-min-date ?min) (search-direction ?d) (not (task-completed)))
    :effect (and (found-total ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (found-total ?amt) (not (task-completed)))
    :effect (and (task-completed))))
