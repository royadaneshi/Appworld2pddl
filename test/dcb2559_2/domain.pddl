(define (domain appworld-dcb2559-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token subscription duration payment-card - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (last-subscription ?s - subscription)
    (subscription-duration ?s - subscription ?d - duration)
    (known-duration ?d - duration)
    (known-payment-card ?c - payment-card)
    (subscribed-prime ?d - duration)
    (prime-renewed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_prime_subscriptions
  (:action amazon-show-prime-subscriptions
    :parameters (?t - token ?s - subscription ?d - duration)
    :precondition (and (has-token amazon ?t) (last-subscription ?s) (subscription-duration ?s ?d) (not (task-completed)))
    :effect (known-duration ?d))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-payment-card ?c))

  ; API: amazon.subscribe_prime
  (:action amazon-subscribe-prime
    :parameters (?c - payment-card ?d - duration ?t - token)
    :precondition (and (has-token amazon ?t) (known-payment-card ?c) (known-duration ?d) (not (prime-renewed)) (not (task-completed)))
    :effect (and (subscribed-prime ?d) (prime-renewed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (prime-renewed) (not (task-completed)))
    :effect (task-completed)))
