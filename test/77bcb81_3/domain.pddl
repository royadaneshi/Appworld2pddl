(define (domain appworld-77bcb81-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person address payment-card product username password token - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (wishlist-known)
    (addresses-known)
    (payment-cards-known)
    (is-home-address ?ad - address)
    (in-wishlist ?p - product)
    (in-cart ?p - product)
    (order-placed)
    (ordered-to-home)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-known)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wishlist-known)))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (wishlist-known) (in-wishlist ?p) (not (order-placed)) (not (task-completed)))
    :effect (and (not (in-wishlist ?p)) (in-cart ?p)))

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
    :parameters (?card - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (wishlist-known) (addresses-known) (payment-cards-known) (is-home-address ?ad) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (ordered-to-home)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (ordered-to-home) (not (task-completed)))
    :effect (and (task-completed)))
)
