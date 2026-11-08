(define (domain appworld-b0934aa-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type price-limit rating-limit product address payment-card - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (target-type ?pt - product-type)
    (target-max-price ?mp - price-limit)
    (target-min-rating ?mr - rating-limit)
    (candidate-found ?p - product)
    (verified-criteria ?p - product)
    (is-home ?ad - address)
    (known-address ?ad - address)
    (known-card ?c - payment-card)
    (cart-empty)
    (in-cart ?p - product)
    (ordered ?p - product ?ad - address)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?mp - price-limit ?mr - rating-limit ?p - product)
    :precondition (and (target-type ?pt) (target-max-price ?mp) (target-min-rating ?mr) (not (task-completed)))
    :effect (candidate-found ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (candidate-found ?p) (not (task-completed)))
    :effect (verified-criteria ?p)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (is-home ?ad) (not (task-completed)))
    :effect (known-address ?ad)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card ?c)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (verified-criteria ?p) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-empty)))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?ad) (is-home ?ad) (in-cart ?p) (not (task-completed)))
    :effect (and (ordered ?p ?ad) (not (in-cart ?p)) (cart-empty))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?ad - address)
    :precondition (and (ordered ?p ?ad) (not (task-completed)))
    :effect (task-completed)
  )
)
