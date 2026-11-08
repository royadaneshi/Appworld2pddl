(define (domain appworld-23d431c-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type price-limit quantity entity - object
    order product seller address payment-card - entity
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (is-past-order ?o - order)
    (contains-product ?o - order ?p - product)
    (seller-of ?p - product ?s - seller)
    (of-type ?p - product ?pt - product-type)
    (price-within ?p - product ?lim - price-limit)
    (query-for ?q - query ?pt - product-type)
    (found-purchased ?p - product)
    (seller-trusted ?s - seller)
    (found-product ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (ordered ?p - product ?q - quantity)
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

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (is-past-order ?o) (not (task-completed)))
    :effect (and (known-id ?o))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (is-past-order ?o) (contains-product ?o ?p) (not (task-completed)))
    :effect (and (known-id ?p) (found-purchased ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?s - seller)
    :precondition (and (known-id ?p) (found-purchased ?p) (seller-of ?p ?s) (not (task-completed)))
    :effect (and (known-id ?s) (seller-trusted ?s))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?lim - price-limit ?s - seller ?p - product)
    :precondition (and (query-for ?q ?pt) (known-id ?s) (seller-trusted ?s) (of-type ?p ?pt) (price-within ?p ?lim) (seller-of ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p) (found-product ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (found-product ?p) (cart-cleared) (not (task-completed)))
    :effect (and (in-cart ?p ?q))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?card))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q) (not (in-cart ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity)
    :precondition (and (ordered ?p ?q) (not (task-completed)))
    :effect (and (task-completed))
  )
)
