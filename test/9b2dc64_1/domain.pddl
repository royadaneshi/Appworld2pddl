(define (domain appworld-9b2dc64-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person entity username password token query color size - object
    product address payment-card - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (last-purchased-tshirt ?p - product)
    (known-id ?x - entity)
    (details-known ?p - product)
    (variant-of ?v - product ?base - product)
    (has-color ?v - product ?c - color)
    (query-for ?q - query ?base - product)
    (size-of ?s - size ?base - product)
    (to-order ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (home-address ?ad - address)
    (order-placed)
    (ordered ?p - product)
    (delivered-home)
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

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (last-purchased-tshirt ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (details-known ?p))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?c - color ?s - size ?v - product ?base - product)
    :precondition (and (details-known ?base) (query-for ?q ?base) (size-of ?s ?base) (variant-of ?v ?base) (has-color ?v ?c) (not (task-completed)))
    :effect (known-id ?v))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (known-id ?p) (to-order ?p) (has-token amazon ?t) (cart-cleared) (not (in-cart ?p)) (not (order-placed)) (not (task-completed)))
    :effect (in-cart ?p))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (home-address ?ad) (not (task-completed)))
    :effect (known-id ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?v1 - product ?v2 - product)
    :precondition (and (known-id ?c) (known-id ?ad) (home-address ?ad) (has-token amazon ?t) (in-cart ?v1) (in-cart ?v2) (not (= ?v1 ?v2)) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (ordered ?v1) (ordered ?v2) (delivered-home) (not (in-cart ?v1)) (not (in-cart ?v2))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?v1 - product ?v2 - product)
    :precondition (and (ordered ?v1) (ordered ?v2) (not (= ?v1 ?v2)) (delivered-home) (not (task-completed)))
    :effect (task-completed))
)
