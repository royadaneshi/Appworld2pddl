(define (domain appworld-953b296-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type size quantity bool-flag entity - object
    product payment-card address - entity
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (purchased-before ?p - product)
    (candidate ?p - product)
    (of-type ?p - product ?pt - product-type)
    (has-size ?p - product ?s - size)
    (query-for-type ?q - query ?pt - product-type)
    (found-size ?s - size)
    (search-found ?p - product)
    (qa-checked ?p - product)
    (reviews-checked ?p - product)
    (in-cart ?p - product ?qty - quantity)
    (home-address-known)
    (is-home-address ?a - address)
    (ordered ?p - product ?qty - quantity ?a - address)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (purchased-before ?p) (not (task-completed)))
    :effect (and (known-id ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?s - size)
    :precondition (and (known-id ?p) (purchased-before ?p) (has-size ?p ?s) (not (task-completed)))
    :effect (and (found-size ?s))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?s - size ?p - product)
    :precondition (and (found-size ?s) (query-for-type ?q ?pt) (candidate ?p) (of-type ?p ?pt) (has-size ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p) (search-found ?p))
  )

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product)
    :precondition (and (search-found ?p) (not (task-completed)))
    :effect (and (qa-checked ?p))
  )

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product)
    :precondition (and (search-found ?p) (not (task-completed)))
    :effect (and (reviews-checked ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - bool-flag)
    :precondition (and (has-token amazon ?t) (search-found ?p) (qa-checked ?p) (reviews-checked ?p) (not (task-completed)))
    :effect (and (in-cart ?p ?qty))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (home-address-known))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address-known) (is-home-address ?a) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (known-id ?c) (known-id ?a) (is-home-address ?a) (has-token amazon ?t) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (ordered ?p ?qty ?a) (not (in-cart ?p ?qty)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?qty - quantity ?a - address)
    :precondition (and (ordered ?p ?qty ?a) (qa-checked ?p) (reviews-checked ?p) (is-home-address ?a) (not (task-completed)))
    :effect (and (task-completed))
  )
)
