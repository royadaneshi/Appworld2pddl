(define (domain appworld-383a053-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type rating quantity order - object
    entity - object
    product address payment-card - entity)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (supervisor-addresses-known)
    (is-work-address ?a - address)
    (product-type-of ?p - product ?pt - product-type)
    (required-product-rating ?r - rating)
    (required-seller-rating ?r - rating)
    (qualified ?p - product)
    (target-quantity ?q - quantity)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?o - order)
    (order-contains ?o - order ?p - product ?q - quantity)
    (order-shipped-to ?o - order ?a - address)
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
    :parameters (?pt - product-type ?minpr - rating ?minsr - rating ?p - product)
    :precondition (and (product-type-of ?p ?pt) (required-product-rating ?minpr) (required-seller-rating ?minsr) (not (task-completed)))
    :effect (and (known-id ?p) (qualified ?p)))

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (not (task-completed))
    :effect (supervisor-addresses-known))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (supervisor-addresses-known) (is-work-address ?a) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (qualified ?p) (cart-cleared) (target-quantity ?q) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?p ?q) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-contains ?o ?p ?q) (order-shipped-to ?o ?a) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?q - quantity ?a - address)
    :precondition (and (order-placed ?o) (order-contains ?o ?p ?q) (order-shipped-to ?o ?a) (is-work-address ?a) (target-quantity ?q) (not (task-completed)))
    :effect (task-completed))
)
