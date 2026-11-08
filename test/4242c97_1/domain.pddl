(define (domain appworld-4242c97-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relative-size color quantity flag record - object
    product address payment-card - record)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (product-query ?p - product ?q - query)
    (product-size ?p - product ?s - relative-size)
    (more-preferred ?c1 - color ?c2 - color)
    (known-id ?x - record)
    (found-product ?p - product)
    (variant-verified ?p - product)
    (in-cart ?p - product ?qty - quantity)
    (order-placed ?p - product ?qty - quantity)
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
    :parameters (?q - query ?size - relative-size ?p - product)
    :precondition (and (product-query ?p ?q) (product-size ?p ?size) (not (task-completed)))
    :effect (and (found-product ?p) (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-product ?p) (known-id ?p) (not (task-completed)))
    :effect (variant-verified ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (variant-verified ?p) (not (in-cart ?p ?qty)) (not (task-completed)))
    :effect (in-cart ?p ?qty))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (order-placed ?p ?qty) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?qty - quantity)
    :precondition (and (order-placed ?p ?qty) (not (task-completed)))
    :effect (task-completed))
)
