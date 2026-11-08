(define (domain appworld-9b2dc64-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type color size address card - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (last-purchased-of-type ?p - product ?pt - product-type)
    (variant-of ?v - product ?p - product)
    (has-color ?p - product ?c - color)
    (has-size ?p - product ?s - size)
    (wanted-color ?c - color)
    (is-home-address ?a - address)
    (known-product ?p - product)
    (product-details-known ?p - product)
    (found-size ?s - size)
    (cart-cleared)
    (in-cart ?p - product)
    (known-address ?a - address)
    (known-card ?pc - card)
    (order-placed)
    (ordered ?p - product)
    (delivered-to ?a - address)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  (:action amazon-show-product-purchases
    ; API: amazon.show_product_purchases
    :parameters (?t - token ?p - product ?pt - product-type)
    :precondition (and (has-token amazon ?t) (last-purchased-of-type ?p ?pt) (not (task-completed)))
    :effect (and (known-product ?p)))

  (:action amazon-show-product
    ; API: amazon.show_product
    :parameters (?p - product ?s - size)
    :precondition (and (known-product ?p) (has-size ?p ?s) (not (task-completed)))
    :effect (and (product-details-known ?p) (found-size ?s)))

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared)))

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?v - product ?t - token ?p - product ?c - color ?s - size)
    :precondition (and (has-token amazon ?t) (cart-cleared) (product-details-known ?p) (variant-of ?v ?p) (has-color ?v ?c) (wanted-color ?c) (has-size ?v ?s) (found-size ?s) (not (in-cart ?v)) (not (task-completed)))
    :effect (and (in-cart ?v)))

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?a) (not (task-completed)))
    :effect (and (known-address ?a)))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?pc - card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?pc)))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?pc - card ?a - address ?t - token ?v1 - product ?v2 - product)
    :precondition (and (has-token amazon ?t) (known-card ?pc) (known-address ?a) (is-home-address ?a) (in-cart ?v1) (in-cart ?v2) (not (= ?v1 ?v2)) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (ordered ?v1) (ordered ?v2) (not (in-cart ?v1)) (not (in-cart ?v2)) (delivered-to ?a)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?v1 - product ?v2 - product ?a - address)
    :precondition (and (ordered ?v1) (ordered ?v2) (not (= ?v1 ?v2)) (delivered-to ?a) (is-home-address ?a) (not (task-completed)))
    :effect (and (task-completed))))
