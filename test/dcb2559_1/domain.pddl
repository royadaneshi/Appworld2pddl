(define (domain appworld-dcb2559-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token subscription duration payment-card - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (latest-subscription ?s - subscription)
    (subscription-duration ?s - subscription ?d - duration)
    (found-subscription ?s - subscription)
    (known-duration ?d - duration)
    (known-card ?c - payment-card)
    (subscribed-premium ?d - duration)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (passwords-known)) (not (task-completed)))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for spotify ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_premium_subscriptions
  (:action spotify-show-premium-subscriptions
    :parameters (?t - token ?s - subscription ?d - duration)
    :precondition (and (has-token spotify ?t)
                       (latest-subscription ?s)
                       (subscription-duration ?s ?d)
                       (not (task-completed)))
    :effect (and (found-subscription ?s) (known-duration ?d)))

  ; API: spotify.show_payment_cards
  (:action spotify-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token spotify ?t)
                       (not (task-completed)))
    :effect (known-card ?c))

  ; API: spotify.subscribe_premium
  (:action spotify-subscribe-premium
    :parameters (?c - payment-card ?d - duration ?t - token)
    :precondition (and (has-token spotify ?t)
                       (known-card ?c)
                       (known-duration ?d)
                       (not (subscribed-premium ?d))
                       (not (task-completed)))
    :effect (subscribed-premium ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - duration)
    :precondition (and (subscribed-premium ?d)
                       (known-duration ?d)
                       (not (task-completed)))
    :effect (task-completed))
)
