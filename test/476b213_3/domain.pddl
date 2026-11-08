(define (domain appworld-476b213-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token prime-subscription payment-card card-name - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (latest-subscription ?s - prime-subscription)
    (paid-with ?s - prime-subscription ?c - payment-card)
    (found-subscription ?s - prime-subscription)
    (known-id ?c - payment-card)
    (found-card-name ?c - payment-card ?n - card-name)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?s - prime-subscription ?c - payment-card)
    :precondition (and (has-token amazon ?t) (latest-subscription ?s) (paid-with ?s ?c) (not (task-completed)))
    :effect (and (found-subscription ?s) (known-id ?c))
  )

  ; API: amazon.show_payment_card
  (:action amazon-show-payment-card
    :parameters (?c - payment-card ?t - token ?n - card-name)
    :precondition (and (known-id ?c) (has-token amazon ?t) (not (task-completed)))
    :effect (and (found-card-name ?c ?n))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - card-name ?s - prime-subscription ?c - payment-card)
    :precondition (and (latest-subscription ?s) (paid-with ?s ?c) (found-subscription ?s) (found-card-name ?c ?n) (not (task-completed)))
    :effect (and (task-completed))
  )
)
