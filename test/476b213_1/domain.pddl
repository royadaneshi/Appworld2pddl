(define (domain appworld-476b213-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token prime-subscription payment-card card-name - object)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (last-subscription ?s - prime-subscription)
    (paid-with ?s - prime-subscription ?c - payment-card)
    (card-named ?c - payment-card ?n - card-name)
    (found-last-subscription ?s - prime-subscription)
    (known-id ?c - payment-card)
    (found-card-name ?c - payment-card ?n - card-name)
    (answer-known ?n - card-name)
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
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?s - prime-subscription ?c - payment-card)
    :precondition (and (has-token amazon ?t)
                       (last-subscription ?s)
                       (paid-with ?s ?c)
                       (not (task-completed)))
    :effect (and (found-last-subscription ?s)
                 (known-id ?c)))

  ; API: amazon.show_payment_card
  (:action amazon-show-payment-card
    :parameters (?c - payment-card ?t - token ?n - card-name)
    :precondition (and (has-token amazon ?t)
                       (known-id ?c)
                       (card-named ?c ?n)
                       (not (task-completed)))
    :effect (and (found-card-name ?c ?n)
                 (answer-known ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - card-name)
    :precondition (and (answer-known ?n)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
