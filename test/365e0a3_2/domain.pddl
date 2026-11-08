(define (domain appworld-365e0a3-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token amount - object
  )
  (:constants
    supervisor spotify - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-total-paid ?amt - amount)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_premium_subscriptions
  (:action spotify-show-premium-subscriptions
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (found-total-paid ?amt))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (found-total-paid ?amt) (not (task-completed)))
    :effect (and (task-completed))
  )
)
