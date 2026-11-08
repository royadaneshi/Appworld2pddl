(define (domain appworld-b0934aa-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type price rating quantity flag product address payment-card - object
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (search-criteria ?q - query ?pt - product-type ?maxp - price ?minr - rating)
    (quantity-one ?qty - quantity)
    (clear-cart-flag ?f - flag)
    (target-delivery ?ad - address)
    (candidate-product ?p - product)
    (reviews-verified ?p - product)
    (in-cart ?p - product)
    (address-details-known ?ad - address)
    (known-address-id ?ad - address)
    (known-card-id ?pc - payment-card)
    (ordered ?p - product ?ad - address)
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
    :parameters (?q - query ?pt - product-type ?maxp - price ?minr - rating ?p - product)
    :precondition (and (search-criteria ?q ?pt ?maxp ?minr) (not (task-completed)))
    :effect (and (candidate-product ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (candidate-product ?p) (not (task-completed)))
    :effect (and (reviews-verified ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?f - flag)
    :precondition (and (has-token amazon ?t) (candidate-product ?p) (reviews-verified ?p) (quantity-one ?qty) (clear-cart-flag ?f) (not (task-completed)))
    :effect (and (in-cart ?p))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters (?ad - address)
    :precondition (and (target-delivery ?ad) (not (task-completed)))
    :effect (and (address-details-known ?ad))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (address-details-known ?ad) (not (task-completed)))
    :effect (and (known-address-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?pc - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card-id ?pc))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?pc - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-card-id ?pc) (known-address-id ?ad) (in-cart ?p) (not (task-completed)))
    :effect (and (ordered ?p ?ad) (not (in-cart ?p)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?ad - address)
    :precondition (and (target-delivery ?ad) (ordered ?p ?ad) (not (task-completed)))
    :effect (and (task-completed))
  )
)
