(define (domain appworld-b0934aa-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type amount rating quantity flag entity - object
    product address payment-card - entity)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for-type ?q - query ?pt - product-type)
    (known-product-type ?pt - product-type)
    (price-limit ?amt - amount)
    (rating-limit ?r - rating)
    (product-of-type ?p - product ?pt - product-type)
    (found-candidate ?p - product)
    (verified-criteria ?p - product)
    (known-id ?x - entity)
    (unit-quantity ?q - quantity)
    (clear-first ?f - flag)
    (in-cart ?p - product ?q - quantity)
    (is-home-address ?addr - address)
    (known-address-details ?addr - address)
    (order-placed ?p - product ?addr - address)
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

  ; API: amazon.search_product_types
  (:action amazon-search-product-types
    :parameters (?q - query ?pt - product-type)
    :precondition (and (query-for-type ?q ?pt) (not (task-completed)))
    :effect (known-product-type ?pt))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?maxp - amount ?minr - rating ?p - product)
    :precondition (and (known-product-type ?pt) (query-for-type ?q ?pt) (price-limit ?maxp) (rating-limit ?minr) (product-of-type ?p ?pt) (not (task-completed)))
    :effect (and (found-candidate ?p) (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-candidate ?p) (known-id ?p) (not (task-completed)))
    :effect (verified-criteria ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (verified-criteria ?p) (unit-quantity ?qty) (clear-first ?clear) (not (task-completed)))
    :effect (in-cart ?p ?qty))

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters (?addr - address)
    :precondition (and (is-home-address ?addr) (not (task-completed)))
    :effect (known-address-details ?addr))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (known-address-details ?addr) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (is-home-address ?addr) (in-cart ?p ?qty) (unit-quantity ?qty) (not (task-completed)))
    :effect (and (order-placed ?p ?addr) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?addr - address)
    :precondition (and (order-placed ?p ?addr) (is-home-address ?addr) (not (task-completed)))
    :effect (task-completed)))
