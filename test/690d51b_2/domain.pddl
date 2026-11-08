(define (domain appworld-690d51b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type price quantity flag order entity - object
    product address payment-card - entity)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (search-matches ?q - query ?pt - product-type)
    (product-matches ?p - product ?pt - product-type ?max - price)
    (budget ?max - price)
    (known-id ?x - entity)
    (unit-quantity ?qty - quantity)
    (flag-true ?f - flag)
    (is-work-address ?addr - address)
    (cart-only ?p - product ?qty - quantity)
    (order-placed ?o - order ?p - product ?qty - quantity ?addr - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?max - price ?p - product)
    :precondition (and (search-matches ?q ?pt) (budget ?max) (product-matches ?p ?pt ?max) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (unit-quantity ?qty) (flag-true ?clear) (not (task-completed)))
    :effect (and (cart-only ?p ?qty)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (is-work-address ?addr) (not (task-completed)))
    :effect (and (known-id ?addr)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (cart-only ?p ?qty) (not (task-completed)))
    :effect (and (order-placed ?o ?p ?qty ?addr) (not (cart-only ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?qty - quantity ?addr - address)
    :precondition (and (order-placed ?o ?p ?qty ?addr) (is-work-address ?addr) (not (task-completed)))
    :effect (and (task-completed))))
