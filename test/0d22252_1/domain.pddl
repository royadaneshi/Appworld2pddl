(define (domain appworld-0d22252-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product quantity payment-card address - object
  )
  (:constants
    amazon - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-wrench-set ?p - product)
    (wish-listed ?p - product ?q - quantity)
    (wish-list-known)
    (cart-clean)
    (in-cart ?p - product ?q - quantity)
    (known-payment-card ?c - payment-card)
    (known-address ?ad - address)
    (order-placed)
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

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-known))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-clean)) (not (order-placed)) (not (task-completed)))
    :effect (and (cart-clean))
  )

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (wish-list-known) (cart-clean) (is-wrench-set ?p) (wish-listed ?p ?q) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (wish-listed ?p ?q)))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-payment-card ?c))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-payment-card ?c) (known-address ?ad) (cart-clean) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
