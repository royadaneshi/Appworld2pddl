(define (domain appworld-365e0a3-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token amount page-limit - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-prime-total ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?lim - page-limit ?total - amount)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (found-prime-total ?total)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?total - amount)
    :precondition (and (found-prime-total ?total) (not (task-completed)))
    :effect (and (task-completed))))
