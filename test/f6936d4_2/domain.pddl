(define (domain appworld-f6936d4-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person entity username password token query product-type quantity order - object
    product address payment-card - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?pt - product-type)
    (product-of-type ?p - product ?pt - product-type)
    (known-id ?x - entity)
    (delivers-by-deadline ?p - product)
    (is-home ?ad - address)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?o - order)
    (ordered ?o - order ?p - product ?q - quantity)
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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?p - product)
    :precondition (and (query-for ?q ?pt) (product-of-type ?p ?pt) (not (task-completed)))
    :effect (and (known-id ?p) (delivers-by-deadline ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (known-id ?p) (delivers-by-deadline ?p) (has-token amazon ?t) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (is-home ?ad) (not (task-completed)))
    :effect (known-id ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?p1 - product ?p2 - product ?q - quantity)
    :precondition (and (known-id ?c) (known-id ?ad) (is-home ?ad) (has-token amazon ?t) (in-cart ?p1 ?q) (in-cart ?p2 ?q) (not (= ?p1 ?p2)) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (ordered ?o ?p1 ?q) (ordered ?o ?p2 ?q) (not (in-cart ?p1 ?q)) (not (in-cart ?p2 ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p1 - product ?p2 - product ?q - quantity)
    :precondition (and (order-placed ?o) (ordered ?o ?p1 ?q) (ordered ?o ?p2 ?q) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (task-completed)))
