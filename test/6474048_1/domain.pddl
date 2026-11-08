(define (domain appworld-6474048-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query rating product payment-card address - object
  )
  (:constants
    amazon - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for-product ?q - query ?p - product)
    (rating-threshold ?r - rating)
    (known-id ?p - product)
    (seller-rating-ok ?p - product)
    (fits-countertop ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (known-card ?c - payment-card)
    (known-address ?ad - address)
    (purchased ?p - product)
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
    :parameters (?q - query ?r - rating ?p - product)
    :precondition (and (query-for-product ?q ?p) (rating-threshold ?r) (not (task-completed)))
    :effect (and (known-id ?p) (seller-rating-ok ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (fits-countertop ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?p) (seller-rating-ok ?p) (fits-countertop ?p) (cart-cleared) (not (in-cart ?p)) (not (task-completed)))
    :effect (and (in-cart ?p))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?ad) (in-cart ?p) (not (purchased ?p)) (not (task-completed)))
    :effect (and (purchased ?p) (not (in-cart ?p)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product)
    :precondition (and (purchased ?p) (not (task-completed)))
    :effect (and (task-completed))
  )
)
