(define (domain appworld-3f3c139-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token payment-card - object)
  (:constants supervisor amazon spotify venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (card-of ?a - app ?c - payment-card)
    (expired ?c - payment-card)
    (cards-listed ?a - app)
    (deleted ?c - payment-card)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cards-listed amazon)
  )

  ; API: amazon.delete_payment_card
  (:action amazon-delete-payment-card
    :parameters (?c - payment-card ?t - token)
    :precondition (and (has-token amazon ?t) (cards-listed amazon) (card-of amazon ?c) (expired ?c) (not (deleted ?c)) (not (task-completed)))
    :effect (deleted ?c)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_payment_cards
  (:action spotify-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (cards-listed spotify)
  )

  ; API: spotify.delete_payment_card
  (:action spotify-delete-payment-card
    :parameters (?c - payment-card ?t - token)
    :precondition (and (has-token spotify ?t) (cards-listed spotify) (card-of spotify ?c) (expired ?c) (not (deleted ?c)) (not (task-completed)))
    :effect (deleted ?c)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (cards-listed venmo)
  )

  ; API: venmo.delete_payment_card
  (:action venmo-delete-payment-card
    :parameters (?c - payment-card ?t - token)
    :precondition (and (has-token venmo ?t) (cards-listed venmo) (card-of venmo ?c) (expired ?c) (not (deleted ?c)) (not (task-completed)))
    :effect (deleted ?c)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ca - payment-card ?cs - payment-card ?cv - payment-card)
    :precondition (and (card-of amazon ?ca) (expired ?ca) (deleted ?ca) (card-of spotify ?cs) (expired ?cs) (deleted ?cs) (card-of venmo ?cv) (expired ?cv) (deleted ?cv) (not (task-completed)))
    :effect (task-completed)
  )
)
