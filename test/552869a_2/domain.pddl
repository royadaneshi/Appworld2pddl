(define (domain appworld-552869a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime direction amount - object
  )
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (target-filter ?q - query ?min - datetime ?dir - direction)
    (found-total ?total - amount)
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

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?q - query ?min - datetime ?dir - direction ?total - amount)
    :precondition (and (has-token venmo ?t) (target-filter ?q ?min ?dir) (not (task-completed)))
    :effect (and (found-total ?total))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (found-total ?ans) (not (task-completed)))
    :effect (and (task-completed))
  )
)
