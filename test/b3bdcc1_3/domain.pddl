(define (domain appworld-b3bdcc1-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token quantity product-type entity - object
    seller product address payment-card - entity
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (of-type ?p - product ?pt - product-type)
    (sold-by ?p - product ?s - seller)
    (highest-rated-seller-for ?s - seller ?pt - product-type)
    (seller-rating-known ?s - seller)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (ordered ?p - product ?q - quantity ?c - payment-card ?ad - address)
    (task-completed)
  )

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  (:action amazon-search-products
    ; API: amazon.search_products
    :parameters (?pt - product-type ?p - product ?s - seller)
    :precondition (and (of-type ?p ?pt) (sold-by ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p) (known-id ?s))
  )

  (:action amazon-show-seller
    ; API: amazon.show_seller
    :parameters (?s - seller)
    :precondition (and (known-id ?s) (not (task-completed)))
    :effect (seller-rating-known ?s)
  )

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad)
  )

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty)
  )

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?p - product ?t - token ?q - quantity ?s - seller ?pt - product-type)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-empty) (of-type ?p ?pt) (sold-by ?p ?s) (seller-rating-known ?s) (highest-rated-seller-for ?s ?pt) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (cart-empty)))
  )

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?c ?ad) (not (in-cart ?p ?q)) (cart-empty))
  )

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?p - product ?q - quantity ?c - payment-card ?ad - address)
    :precondition (and (ordered ?p ?q ?c ?ad) (not (task-completed)))
    :effect (task-completed)
  )
)
