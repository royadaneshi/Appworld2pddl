(define (domain appworld-3f3c139-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token card - object
  )
  (:constants
    amazon spotify venmo - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (account-username ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (card-of ?c - card ?a - app)
    (expired ?c - card)
    (cards-listed ?a - app)
    (card-deleted ?c - card)
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
    :precondition (and
      (passwords-known)
      (account-username amazon ?u)
      (password-for amazon ?pw)
      (token-for amazon ?t)
      (not (has-token amazon ?t))
      (not (task-completed))
    )
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and
      (has-token amazon ?t)
      (not (task-completed))
    )
    :effect (and (cards-listed amazon))
  )

  ; API: amazon.delete_payment_card
  (:action amazon-delete-payment-card
    :parameters (?c - card ?t - token)
    :precondition (and
      (has-token amazon ?t)
      (cards-listed amazon)
      (card-of ?c amazon)
      (expired ?c)
      (not (card-deleted ?c))
      (not (task-completed))
    )
    :effect (and (card-deleted ?c))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (account-username spotify ?u)
      (password-for spotify ?pw)
      (token-for spotify ?t)
      (not (has-token spotify ?t))
      (not (task-completed))
    )
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.show_payment_cards
  (:action spotify-show-payment-cards
    :parameters (?t - token)
    :precondition (and
      (has-token spotify ?t)
      (not (task-completed))
    )
    :effect (and (cards-listed spotify))
  )

  ; API: spotify.delete_payment_card
  (:action spotify-delete-payment-card
    :parameters (?c - card ?t - token)
    :precondition (and
      (has-token spotify ?t)
      (cards-listed spotify)
      (card-of ?c spotify)
      (expired ?c)
      (not (card-deleted ?c))
      (not (task-completed))
    )
    :effect (and (card-deleted ?c))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (account-username venmo ?u)
      (password-for venmo ?pw)
      (token-for venmo ?t)
      (not (has-token venmo ?t))
      (not (task-completed))
    )
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and
      (has-token venmo ?t)
      (not (task-completed))
    )
    :effect (and (cards-listed venmo))
  )

  ; API: venmo.delete_payment_card
  (:action venmo-delete-payment-card
    :parameters (?c - card ?t - token)
    :precondition (and
      (has-token venmo ?t)
      (cards-listed venmo)
      (card-of ?c venmo)
      (expired ?c)
      (not (card-deleted ?c))
      (not (task-completed))
    )
    :effect (and (card-deleted ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c1 ?c2 ?c3 ?c4 - card)
    :precondition (and
      (expired ?c1) (expired ?c2) (expired ?c3) (expired ?c4)
      (not (= ?c1 ?c2)) (not (= ?c1 ?c3)) (not (= ?c1 ?c4))
      (not (= ?c2 ?c3)) (not (= ?c2 ?c4)) (not (= ?c3 ?c4))
      (card-deleted ?c1) (card-deleted ?c2) (card-deleted ?c3) (card-deleted ?c4)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
