(define (domain appworld-23d431c-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type max-price entity - object
    product seller address payment-card - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (past-purchased ?p - product)
    (sold-by ?p - product ?s - seller)
    (has-type ?p - product ?pt - product-type)
    (priced-within ?p - product ?mp - max-price)
    (seller-trusted ?s - seller)
    (found-product ?p - product)
    (cart-empty)
    (in-cart ?p - product)
    (ordered ?p - product)
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

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (past-purchased ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?s - seller)
    :precondition (and (known-id ?p) (past-purchased ?p) (sold-by ?p ?s) (not (task-completed)))
    :effect (and (known-id ?s) (seller-trusted ?s)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?mp - max-price ?s - seller ?p - product)
    :precondition (and (seller-trusted ?s) (known-id ?s) (sold-by ?p ?s) (has-type ?p ?pt) (priced-within ?p ?mp) (not (task-completed)))
    :effect (and (known-id ?p) (found-product ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (found-product ?p) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-empty))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p) (not (task-completed)))
    :effect (and (ordered ?p) (not (in-cart ?p)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product)
    :precondition (and (ordered ?p) (not (task-completed)))
    :effect (task-completed))
)
