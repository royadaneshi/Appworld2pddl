(define (domain appworld-ba46d91-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token subscription day-count - object
  )
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (subscriber ?p - person ?s - subscription)
    (found-days-left ?d - day-count ?s - subscription)
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
    :parameters (?t - token ?s - subscription ?d - day-count)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (found-days-left ?d ?s))
  )
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - day-count ?s - subscription)
    :precondition (and (found-days-left ?d ?s) (not (task-completed)))
    :effect (and (task-completed))
  )
)
