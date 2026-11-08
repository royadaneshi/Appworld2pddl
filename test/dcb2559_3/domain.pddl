(define (domain appworld-dcb2559-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token duration payment-card - object)
  (:constants spotify supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (expired-subscription-duration ?d - duration)
    (found-duration ?d - duration)
    (known-id ?c - payment-card)
    (subscribed ?d - duration)
    (premium-renewed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_premium_subscriptions
  (:action spotify-show-premium-subscriptions
    :parameters (?t - token ?d - duration)
    :precondition (and (has-token spotify ?t) (expired-subscription-duration ?d) (not (task-completed)))
    :effect (and (found-duration ?d)))

  ; API: spotify.show_payment_cards
  (:action spotify-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: spotify.subscribe_premium
  (:action spotify-subscribe-premium
    :parameters (?c - payment-card ?d - duration ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?c) (found-duration ?d) (expired-subscription-duration ?d) (not (premium-renewed)) (not (task-completed)))
    :effect (and (subscribed ?d) (premium-renewed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (premium-renewed) (not (task-completed)))
    :effect (and (task-completed)))
)
