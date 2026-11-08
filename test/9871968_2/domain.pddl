(define (domain appworld-9871968-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token product quantity address payment-card count - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (wishlist-entry ?p - product ?q - quantity)
    (wishlist-listed)
    (cart-cleared)
    (in-cart ?p - product)
    (cart-count ?c - count)
    (count-next ?c1 - count ?c2 - count)
    (wishlist-size ?c - count)
    (is-home ?ad - address)
    (addresses-listed)
    (payment-cards-listed)
    (order-placed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  (:action amazon-show-wish-list
    ; API: amazon.show_wish_list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wishlist-listed))

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (cart-cleared))

  (:action amazon-move-product-from-wish-list-to-cart
    ; API: amazon.move_product_from_wish_list_to_cart
    :parameters (?p - product ?t - token ?q - quantity ?c1 - count ?c2 - count)
    :precondition (and (has-token amazon ?t) (wishlist-listed) (cart-cleared) (wishlist-entry ?p ?q) (not (in-cart ?p)) (cart-count ?c1) (count-next ?c1 ?c2) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-count ?c1)) (cart-count ?c2)))

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-listed))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-cards-listed))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?ad - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (payment-cards-listed) (addresses-listed) (is-home ?ad) (cart-cleared) (cart-count ?n) (wishlist-size ?n) (not (order-placed)) (not (task-completed)))
    :effect (order-placed))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed)))
