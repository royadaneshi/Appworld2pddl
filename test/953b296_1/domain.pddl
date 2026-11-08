(define (domain appworld-953b296-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type size quantity product order card address - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (order-matches ?o - order ?q - query)
    (order-contains ?o - order ?p - product)
    (product-of-type ?p - product ?pt - product-type)
    (product-size ?p - product ?s - size)
    (found-size ?s - size)
    (reviews-checked ?p - product)
    (questions-checked ?p - product)
    (no-fading-reported ?p - product)
    (in-cart ?p - product ?qty - quantity)
    (home-address ?a - address)
    (pending-order ?o - order)
    (order-placed ?o - order)
    (order-has-product ?o - order ?p - product ?qty - quantity)
    (order-address ?o - order ?a - address)
    (task-completed)
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
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-matches ?o ?q) (not (task-completed)))
    :effect (known-id ?o)
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-contains ?o ?p) (not (task-completed)))
    :effect (known-id ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?s - size)
    :precondition (and (known-id ?p) (product-size ?p ?s) (not (task-completed)))
    :effect (found-size ?s)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?s - size ?p - product)
    :precondition (and (found-size ?s) (product-of-type ?p ?pt) (product-size ?p ?s) (not (task-completed)))
    :effect (known-id ?p)
  )

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (reviews-checked ?p)
  )

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (questions-checked ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (reviews-checked ?p) (questions-checked ?p) (no-fading-reported ?p) (not (task-completed)))
    :effect (in-cart ?p ?qty)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?a - address ?t - token ?p - product ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (home-address ?a) (in-cart ?p ?qty) (pending-order ?o) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-has-product ?o ?p ?qty) (order-address ?o ?a) (known-id ?o) (not (in-cart ?p ?qty)) (not (pending-order ?o)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?pt - product-type ?s - size ?qty - quantity ?a - address)
    :precondition (and (found-size ?s) (product-of-type ?p ?pt) (product-size ?p ?s) (reviews-checked ?p) (questions-checked ?p) (no-fading-reported ?p) (order-placed ?o) (order-has-product ?o ?p ?qty) (order-address ?o ?a) (home-address ?a) (not (task-completed)))
    :effect (task-completed)
  )
)
