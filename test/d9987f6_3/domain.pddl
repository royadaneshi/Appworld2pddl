(define (domain appworld-d9987f6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type rating quantity entity - object
    product address payment-card - entity
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-for ?q - query ?pt - product-type)
    (product-type-of ?p - product ?pt - product-type)
    (rating-over ?p - product ?r - rating)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (supervisor-addresses-known)
    (order-placed ?p - product ?addr - address)
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
    :parameters (?q - query ?pt - product-type ?r - rating ?p - product)
    :precondition (and (query-for ?q ?pt) (product-type-of ?p ?pt) (rating-over ?p ?r) (not (task-completed)))
    :effect (and (known-id ?p))
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
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (task-completed)))
    :effect (and (in-cart ?p ?q))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (supervisor-addresses-known))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (supervisor-addresses-known) (not (task-completed)))
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
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?addr) (not (in-cart ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?addr - address)
    :precondition (and (order-placed ?p ?addr) (not (task-completed)))
    :effect (and (task-completed))
  )
)
