(define (domain appworld-77bcb81-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product address payment-card - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (cart-known)
    (wish-list-known)
    (addresses-known)
    (payment-cards-known)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (order-placed)
    (order-placed-to ?addr - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-known))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wish-list-known))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (wish-list-known) (in-wish-list ?p) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p) (not (in-wish-list ?p))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-known))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-cards-known))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (wish-list-known) (payment-cards-known) (addresses-known) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (order-placed-to ?addr)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed))
)
