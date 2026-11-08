(define (domain appworld-9871968-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product quantity record - object
    address payment-card - record
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wishlist-shown)
    (on-wishlist ?p - product)
    (wishlist-quantity ?p - product ?q - quantity)
    (cart-cleared)
    (moved-to-cart ?p - product)
    (is-work-address ?addr - address)
    (known-id ?r - record)
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
    :effect (and (wishlist-shown))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (wishlist-shown) (on-wishlist ?p) (wishlist-quantity ?p ?q) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (moved-to-cart ?p) (not (on-wishlist ?p)))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (is-work-address ?addr) (not (task-completed)))
    :effect (and (known-id ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (is-work-address ?addr) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
