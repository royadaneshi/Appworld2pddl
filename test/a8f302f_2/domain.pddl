(define (domain appworld-a8f302f-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type address payment-card - object
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (product-type-of ?p - product ?pt - product-type)
    (cheapest-in-type ?p - product ?pt - product-type)
    (known-address ?ad - address)
    (known-card ?c - payment-card)
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

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-known))
  )

  ; API: amazon.move_product_from_cart_to_wish_list
  (:action amazon-move-product-from-cart-to-wish-list
    :parameters (?p - product ?t - token ?pt - product-type)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (product-type-of ?p ?pt) (not (cheapest-in-type ?p ?pt)) (not (in-wish-list ?p)) (not (order-placed)) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (in-wish-list ?p))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (known-card ?c) (known-address ?ad) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
