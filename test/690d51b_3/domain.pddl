(define (domain appworld-690d51b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type price entity - object
    product address payment-card - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (product-of-type ?p - product ?pt - product-type)
    (product-within-price ?p - product ?mp - price)
    (is-home ?a - address)
    (cart-empty)
    (in-cart ?p - product)
    (order-placed ?p - product ?a - address)
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
    :parameters (?q - query ?pt - product-type ?maxp - price ?p - product)
    :precondition (and (product-of-type ?p ?pt) (product-within-price ?p ?maxp) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home ?a) (not (task-completed)))
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
    :effect (cart-empty))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-empty))))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home ?a) (in-cart ?p) (not (task-completed)))
    :effect (and (order-placed ?p ?a) (not (in-cart ?p)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?a - address)
    :precondition (and (order-placed ?p ?a) (is-home ?a) (not (task-completed)))
    :effect (task-completed))
)
