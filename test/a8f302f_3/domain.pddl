(define (domain appworld-a8f302f-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type address payment-card count - object
  )
  (:constants
    amazon - app
    count-0 - count
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (cart-known)
    (addresses-known)
    (payment-cards-known)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (of-type ?p - product ?pt - product-type)
    (cheapest ?p - product)
    (moves-left ?n - count)
    (succ ?m - count ?n - count)
    (order-placed)
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
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (not (cheapest ?p)) (not (order-placed)) (moves-left ?n) (succ ?m ?n) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (in-wish-list ?p) (not (moves-left ?n)) (moves-left ?m))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (addresses-known))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (payment-cards-known))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (payment-cards-known) (addresses-known) (moves-left count-0) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
