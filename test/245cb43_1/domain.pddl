(define (domain appworld-245cb43-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product card address flag - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (wish-list-shown)
    (in-wish-list ?p - product)
    (dish-rack ?p - product)
    (fits-countertop ?p - product)
    (dimensions-known ?p - product)
    (clear-first ?f - flag)
    (cart-contains-only ?p - product)
    (payment-cards-shown)
    (addresses-shown)
    (supervisor-card ?c - card)
    (supervisor-address ?ad - address)
    (ordered ?p - product)
    (fitting-dish-rack-ordered)
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
    :effect (and (wish-list-shown))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (wish-list-shown) (in-wish-list ?p) (not (task-completed)))
    :effect (and (dimensions-known ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?f - flag)
    :precondition (and (has-token amazon ?t) (in-wish-list ?p) (dimensions-known ?p) (dish-rack ?p) (fits-countertop ?p) (clear-first ?f) (not (task-completed)))
    :effect (and (cart-contains-only ?p))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (payment-cards-shown))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (addresses-shown))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (payment-cards-shown) (supervisor-card ?c) (addresses-shown) (supervisor-address ?ad) (cart-contains-only ?p) (dish-rack ?p) (fits-countertop ?p) (not (fitting-dish-rack-ordered)) (not (task-completed)))
    :effect (and (ordered ?p) (fitting-dish-rack-ordered) (not (cart-contains-only ?p)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (fitting-dish-rack-ordered) (not (task-completed)))
    :effect (and (task-completed))
  )
)
