(define (domain appworld-d9987f6-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query rating product quantity address payment-card - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (search-query ?q - query)
    (min-rating ?r - rating)
    (quantity-one ?n - quantity)
    (is-work-address ?ad - address)
    (known-id ?x - object)
    (rating-ok ?p - product)
    (cart-empty)
    (in-cart ?p - product)
    (ordered ?p - product ?ad - address)
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
    :precondition (and (search-query ?q) (min-rating ?r) (not (task-completed)))
    :effect (and (known-id ?p) (rating-ok ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-empty))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?n - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (rating-ok ?p) (cart-empty) (quantity-one ?n) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-empty)))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (is-work-address ?ad) (in-cart ?p) (not (task-completed)))
    :effect (and (ordered ?p ?ad) (not (in-cart ?p)) (cart-empty))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?ad - address)
    :precondition (and (ordered ?p ?ad) (is-work-address ?ad) (not (task-completed)))
    :effect (and (task-completed))
  )
)
