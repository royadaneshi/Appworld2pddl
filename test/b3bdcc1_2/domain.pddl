(define (domain appworld-b3bdcc1-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type quantity entity - object
    seller product card address - entity
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (sellers-known ?pt - product-type)
    (highest-rated-seller ?s - seller ?pt - product-type)
    (sold-by ?p - product ?s - seller)
    (of-type ?p - product ?pt - product-type)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?p - product ?q - quantity ?c - card ?ad - address)
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

  ; API: amazon.show_product_feature_choices
  (:action amazon-show-product-feature-choices
    :parameters (?pt - product-type)
    :precondition (not (task-completed))
    :effect (sellers-known ?pt)
  )

  ; API: amazon.search_sellers
  (:action amazon-search-sellers
    :parameters (?pt - product-type ?s - seller)
    :precondition (and (sellers-known ?pt) (not (task-completed)))
    :effect (and (known-id ?s) (highest-rated-seller ?s ?pt))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?s - seller ?p - product)
    :precondition (and (known-id ?s) (highest-rated-seller ?s ?pt) (not (task-completed)))
    :effect (and (known-id ?p) (sold-by ?p ?s) (of-type ?p ?pt))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (cart-empty)))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?q ?c ?ad) (not (in-cart ?p ?q)) (cart-empty))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?s - seller ?pt - product-type ?q - quantity ?c - card ?ad - address)
    :precondition (and (highest-rated-seller ?s ?pt) (sold-by ?p ?s) (of-type ?p ?pt) (order-placed ?p ?q ?c ?ad) (not (task-completed)))
    :effect (task-completed)
  )
)
