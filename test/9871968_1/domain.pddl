(define (domain appworld-9871968-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token count product address payment-card - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-shown)
    (on-wish-list ?p - product)
    (wish-remaining ?n - count)
    (next-count ?lower - count ?higher - count)
    (zero-count ?n - count)
    (cart-cleared)
    (in-cart ?p - product)
    (addresses-shown)
    (payment-cards-shown)
    (is-work-address ?ad - address)
    (order-placed)
    (order-shipped-to ?ad - address)
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

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wish-list-shown))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (wish-list-shown) (on-wish-list ?p) (cart-cleared) (not (order-placed)) (wish-remaining ?n) (next-count ?m ?n) (not (task-completed)))
    :effect (and (in-cart ?p) (not (on-wish-list ?p)) (not (wish-remaining ?n)) (wish-remaining ?m)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-shown))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-cards-shown))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (payment-cards-shown) (addresses-shown) (is-work-address ?ad) (cart-cleared) (wish-remaining ?n) (zero-count ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (order-shipped-to ?ad)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed))
)
