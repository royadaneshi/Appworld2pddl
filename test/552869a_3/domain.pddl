(define (domain appworld-552869a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime direction amount - object)
  (:constants venmo supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (bill-query ?q - query)
    (year-start ?d - datetime)
    (current-time ?d - datetime)
    (sent-direction ?dir - direction)
    (total-paid-for ?q - query ?amt - amount)
    (found-total ?amt - amount)
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
    :parameters (?t - token ?q - query ?dmin - datetime ?dmax - datetime ?dir - direction ?total - amount)
    :precondition (and (has-token venmo ?t)
                       (bill-query ?q)
                       (year-start ?dmin)
                       (current-time ?dmax)
                       (sent-direction ?dir)
                       (total-paid-for ?q ?total)
                       (not (task-completed)))
    :effect (found-total ?total))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (found-total ?answer)
                       (not (task-completed)))
    :effect (task-completed)))
