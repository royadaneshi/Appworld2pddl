(define (domain appworld-365e0a3-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token amount - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
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
    :precondition (and (passwords-known)
                       (username-for amazon ?u)
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-prime-total ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (found-prime-total ?answer)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
