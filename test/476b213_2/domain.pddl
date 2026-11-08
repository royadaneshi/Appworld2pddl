(define (domain appworld-476b213-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token premium-subscription payment-card card-name - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-last-subscription ?s - premium-subscription)
    (paid-with ?s - premium-subscription ?c - payment-card)
    (card-named ?c - payment-card ?n - card-name)
    (known-id ?s - premium-subscription)
    (known-card-id ?c - payment-card)
    (found-subscription-card ?s - premium-subscription ?c - payment-card)
    (found-card-name ?c - payment-card ?n - card-name)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_premium_subscriptions
  (:action spotify-show-premium-subscriptions
    :parameters (?t - token ?s - premium-subscription ?c - payment-card)
    :precondition (and (has-token spotify ?t) (is-last-subscription ?s) (paid-with ?s ?c) (not (task-completed)))
    :effect (and (known-id ?s) (found-subscription-card ?s ?c) (known-card-id ?c)))

  ; API: spotify.show_payment_card
  (:action spotify-show-payment-card
    :parameters (?c - payment-card ?t - token ?n - card-name)
    :precondition (and (has-token spotify ?t) (known-card-id ?c) (card-named ?c ?n) (not (task-completed)))
    :effect (found-card-name ?c ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - card-name ?c - payment-card)
    :precondition (and (found-card-name ?c ?n) (not (task-completed)))
    :effect (task-completed)))
