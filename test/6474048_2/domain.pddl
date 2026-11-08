(define (domain appworld-6474048-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type rating quantity product record - object
    address payment-card - record
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (product-type-of ?p - product ?pt - product-type)
    (candidate ?p - product)
    (verified-fits ?p - product)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (known-id ?x - record)
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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?r - rating ?p - product)
    :precondition (and (product-type-of ?p ?pt) (not (task-completed)))
    :effect (and (candidate ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (candidate ?p) (not (task-completed)))
    :effect (and (verified-fits ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-empty))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (verified-fits ?p) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?qty) (not (cart-empty)))
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
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (ordered ?p ?qty) (not (in-cart ?p ?qty)) (cart-empty))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?qty - quantity)
    :precondition (and (ordered ?p ?qty) (not (task-completed)))
    :effect (and (task-completed))
  )
)
