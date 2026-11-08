(define (domain appworld-4242c97-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query size quantity order entity - object
    product payment-card address - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (product-query ?p - product ?q - query)
    (product-size ?p - product ?s - size)
    (known-id ?x - entity)
    (cart-cleared)
    (in-cart ?p - product ?qty - quantity)
    (order-placed ?o - order)
    (order-contains ?o - order ?p - product ?qty - quantity)
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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?s - size ?p - product)
    :precondition (and (product-query ?p ?q) (product-size ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (in-cart ?p ?qty)) (not (task-completed)))
    :effect (and (in-cart ?p ?qty)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?p ?qty) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-contains ?o ?p ?qty) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?qty - quantity)
    :precondition (and (order-placed ?o) (order-contains ?o ?p ?qty) (not (task-completed)))
    :effect (and (task-completed))))
