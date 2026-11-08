(define (domain appworld-6474048-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type rating drawer quantity record - object
    product address payment-card - record)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (required-product-type ?pt - product-type)
    (required-min-seller-rating ?r - rating)
    (query-for ?q - query ?pt - product-type)
    (target-drawer ?d - drawer)
    (single-unit ?qty - quantity)
    (candidate ?p - product)
    (has-type ?p - product ?pt - product-type)
    (seller-rating-at-least ?p - product ?r - rating)
    (verified-fits ?p - product)
    (known-id ?x - record)
    (cart-empty)
    (in-cart ?p - product ?qty - quantity)
    (ordered ?p - product ?qty - quantity)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?r - rating ?p - product)
    :precondition (and (query-for ?q ?pt) (required-product-type ?pt) (required-min-seller-rating ?r) (not (task-completed)))
    :effect (and (candidate ?p) (has-type ?p ?pt) (seller-rating-at-least ?p ?r)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?d - drawer)
    :precondition (and (candidate ?p) (target-drawer ?d) (not (task-completed)))
    :effect (verified-fits ?p))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (candidate ?p) (verified-fits ?p) (single-unit ?qty) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?qty) (not (cart-empty))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (in-cart ?p ?qty) (single-unit ?qty) (not (cart-empty)) (not (task-completed)))
    :effect (and (ordered ?p ?qty) (order-placed) (not (in-cart ?p ?qty)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed)))
