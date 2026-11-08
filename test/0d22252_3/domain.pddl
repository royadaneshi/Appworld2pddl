(define (domain appworld-0d22252-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type quantity address payment-card - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (wish-list-seen)
    (in-wish-list ?p - product)
    (wish-list-quantity ?p - product ?q - quantity)
    (is-of-type ?p - product ?pt - product-type)
    (target-product-type ?pt - product-type)
    (product-type-known ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (addresses-known)
    (payment-cards-known)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-seen)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (wish-list-seen) (in-wish-list ?p) (not (task-completed)))
    :effect (and (product-type-known ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?pt - product-type)
    :precondition (and (has-token amazon ?t) (wish-list-seen) (in-wish-list ?p) (wish-list-quantity ?p ?q) (product-type-known ?p) (is-of-type ?p ?pt) (target-product-type ?pt) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p) (not (in-wish-list ?p))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (addresses-known)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (payment-cards-known)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token)
    :precondition (and (has-token amazon ?t) (payment-cards-known) (addresses-known) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))))
