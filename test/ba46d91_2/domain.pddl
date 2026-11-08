(define (domain appworld-ba46d91-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token subscription months - object)
  (:constants
    amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (prime-subscription-of ?p - person ?s - subscription)
    (months-remaining ?s - subscription ?m - months)
    (found-months-left ?m - months)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for amazon ?u)
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?s - subscription ?m - months)
    :precondition (and (has-token amazon ?t)
                       (months-remaining ?s ?m)
                       (not (task-completed)))
    :effect (found-months-left ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?m - months)
    :precondition (and (found-months-left ?m)
                       (not (task-completed)))
    :effect (task-completed)))
