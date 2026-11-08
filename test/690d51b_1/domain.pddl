(define (domain appworld-690d51b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query amount quantity product address payment-card - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (product-matches ?p - product ?q - query)
    (price-within ?p - product ?m - amount)
    (home-address ?addr - address)
    (in-cart ?p - product ?qty - quantity)
    (ordered ?p - product ?addr - address ?qty - quantity)
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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?maxp - amount ?p - product)
    :precondition (and (product-matches ?p ?q) (price-within ?p ?maxp) (not (task-completed)))
    :effect (and (known-id ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (not (task-completed)))
    :effect (and (in-cart ?p ?qty))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (home-address ?addr) (not (task-completed)))
    :effect (and (known-id ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (ordered ?p ?addr ?qty) (not (in-cart ?p ?qty)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?addr - address ?qty - quantity)
    :precondition (and (ordered ?p ?addr ?qty) (not (task-completed)))
    :effect (and (task-completed))
  )
)
