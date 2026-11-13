(define (domain appworld-0d22252-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type quantity record - object
    address payment-card - record
  )
  (:constants
    amazon supervisor - app
    mouse-pad - product-type
    other-product-1 other-product-2 mouse-pad-1 mouse-pad-2 mouse-pad-3 mouse-pad-4 mouse-pad-5 other-product-3 other-product-4 other-product-5 other-product-6 other-product-7 other-product-8 other-product-9 other-product-10 other-product-11 - product
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-known)
    (in-wish-list ?p - product)
    (wish-list-quantity ?p - product ?q - quantity)
    (type-known ?p - product)
    (is-type ?p - product ?pt - product-type)
    (cart-cleared)
    (in-cart ?p - product)
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
    :effect (and (wish-list-known))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (wish-list-known) (in-wish-list ?p) (not (task-completed)))
    :effect (and (type-known ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (wish-list-known) (in-wish-list ?p) (type-known ?p) (is-type ?p mouse-pad) (wish-list-quantity ?p ?q) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (not (in-wish-list ?p)) (in-cart ?p))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (order-placed)
      (in-cart mouse-pad-1)
      (in-cart mouse-pad-2)
      (in-cart mouse-pad-3)
      (in-cart mouse-pad-4)
      (in-cart mouse-pad-5)
      (in-wish-list other-product-1)
      (not (in-cart other-product-1))
      (in-wish-list other-product-2)
      (not (in-cart other-product-2))
      (in-wish-list other-product-3)
      (not (in-cart other-product-3))
      (in-wish-list other-product-4)
      (not (in-cart other-product-4))
      (in-wish-list other-product-5)
      (not (in-cart other-product-5))
      (in-wish-list other-product-6)
      (not (in-cart other-product-6))
      (in-wish-list other-product-7)
      (not (in-cart other-product-7))
      (in-wish-list other-product-8)
      (not (in-cart other-product-8))
      (in-wish-list other-product-9)
      (not (in-cart other-product-9))
      (in-wish-list other-product-10)
      (not (in-cart other-product-10))
      (in-wish-list other-product-11)
      (not (in-cart other-product-11))
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
