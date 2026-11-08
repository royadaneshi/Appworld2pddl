(define (domain appworld-383a053-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query rating quantity entity - object
    product address payment-card - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (product-query ?p - product ?q - query)
    (min-product-rating ?r - rating)
    (min-seller-rating ?r - rating)
    (required-quantity ?q - quantity)
    (is-work-address ?addr - address)
    (found-product ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (known-id ?x - entity)
    (order-placed ?p - product ?q - quantity ?addr - address))

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
    :parameters (?q - query ?minpr - rating ?minsr - rating ?p - product)
    :precondition (and (product-query ?p ?q) (min-product-rating ?minpr) (min-seller-rating ?minsr) (not (task-completed)))
    :effect (found-product ?p))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (found-product ?p) (cart-cleared) (required-quantity ?q) (not (task-completed)))
    :effect (in-cart ?p ?q))

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
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (is-work-address ?addr) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?q ?addr) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?addr - address)
    :precondition (and (order-placed ?p ?q ?addr) (is-work-address ?addr) (not (task-completed)))
    :effect (task-completed))
)
