(define (domain appworld-383a053-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query rating quantity record - object
    product address payment-card order - record
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (search-query ?q - query)
    (required-product-rating ?r - rating)
    (required-seller-rating ?r - rating)
    (purchase-count ?n - quantity)
    (is-home-address ?a - address)
    (known-id ?x - record)
    (qualifying-product ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?n - quantity)
    (order-placed ?o - order)
    (order-has ?o - order ?p - product ?n - quantity)
    (order-shipped-to ?o - order ?a - address)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?minpr - rating ?minsr - rating ?p - product)
    :precondition (and (search-query ?q) (required-product-rating ?minpr) (required-seller-rating ?minsr) (not (task-completed)))
    :effect (and (known-id ?p) (qualifying-product ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?n - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (qualifying-product ?p) (cart-cleared) (purchase-count ?n) (not (task-completed)))
    :effect (in-cart ?p ?n)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?a) (not (task-completed)))
    :effect (known-id ?a)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?n - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home-address ?a) (in-cart ?p ?n) (purchase-count ?n) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-has ?o ?p ?n) (order-shipped-to ?o ?a))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?n - quantity ?a - address)
    :precondition (and (order-placed ?o) (order-has ?o ?p ?n) (order-shipped-to ?o ?a) (qualifying-product ?p) (purchase-count ?n) (is-home-address ?a) (not (task-completed)))
    :effect (task-completed)
  )
)
