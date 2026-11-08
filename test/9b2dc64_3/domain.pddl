(define (domain appworld-9b2dc64-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product color size quantity address payment-card - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?p - product)
    (last-purchased-tshirt ?p - product)
    (variant-of ?v - product ?base - product)
    (color-of ?p - product ?c - color)
    (size-of ?p - product ?s - size)
    (wanted-color ?c - color)
    (single-unit ?q - quantity)
    (variants-known ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (addresses-known)
    (payment-cards-known)
    (home-address ?addr - address)
    (ordered ?p - product)
    (order-placed-to ?addr - address)
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

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (last-purchased-tshirt ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (variants-known ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?v - product ?t - token ?q - quantity ?base - product ?c - color ?s - size)
    :precondition (and (has-token amazon ?t) (cart-cleared) (single-unit ?q) (variants-known ?base) (variant-of ?v ?base) (color-of ?v ?c) (wanted-color ?c) (size-of ?v ?s) (size-of ?base ?s) (not (in-cart ?v)) (not (task-completed)))
    :effect (and (in-cart ?v) (known-id ?v)))

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
    :parameters (?card - payment-card ?addr - address ?t - token ?v1 - product ?v2 - product)
    :precondition (and (has-token amazon ?t) (payment-cards-known) (addresses-known) (home-address ?addr) (in-cart ?v1) (in-cart ?v2) (not (= ?v1 ?v2)) (not (ordered ?v1)) (not (ordered ?v2)) (not (task-completed)))
    :effect (and (ordered ?v1) (ordered ?v2) (order-placed-to ?addr)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?v1 - product ?v2 - product ?addr - address)
    :precondition (and (ordered ?v1) (ordered ?v2) (not (= ?v1 ?v2)) (order-placed-to ?addr) (home-address ?addr) (not (task-completed)))
    :effect (and (task-completed))))
