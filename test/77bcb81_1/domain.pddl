(define (domain appworld-77bcb81-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product address payment-card count - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-reviewed)
    (wish-list-reviewed)
    (addresses-known)
    (payment-cards-known)
    (in-wish-list ?p - product)
    (in-cart ?p - product)
    (wish-list-count ?n - count)
    (count-pred ?m - count ?n - count)
    (count-zero ?n - count)
    (home-address ?a - address)
    (order-placed-to ?a - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-reviewed))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wish-list-reviewed))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (wish-list-reviewed) (in-wish-list ?p) (wish-list-count ?n) (count-pred ?m ?n) (not (task-completed)))
    :effect (and (not (in-wish-list ?p)) (in-cart ?p) (not (wish-list-count ?n)) (wish-list-count ?m)))

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
    :parameters (?c - payment-card ?a - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (payment-cards-known) (addresses-known) (home-address ?a) (cart-reviewed) (wish-list-reviewed) (wish-list-count ?n) (count-zero ?n) (not (order-placed-to ?a)) (not (task-completed)))
    :effect (order-placed-to ?a))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?a - address)
    :precondition (and (order-placed-to ?a) (home-address ?a) (not (task-completed)))
    :effect (task-completed))
)
