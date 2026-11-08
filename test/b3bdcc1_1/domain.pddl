(define (domain appworld-b3bdcc1-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type product seller quantity boolean payment-card address order - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (of-type ?p - product ?pt - product-type)
    (sold-by ?p - product ?s - seller)
    (top-rated-seller ?s - seller ?pt - product-type)
    (known-id ?x)
    (seller-rating-known ?s - seller)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?o - order ?p - product ?q - quantity ?c - payment-card ?a - address))

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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?p - product ?s - seller)
    :precondition (and (of-type ?p ?pt) (sold-by ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p) (known-id ?s)))

  ; API: amazon.show_seller
  (:action amazon-show-seller
    :parameters (?s - seller)
    :precondition (and (known-id ?s) (not (task-completed)))
    :effect (seller-rating-known ?s))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?clear - boolean ?s - seller ?pt - product-type)
    :precondition (and (has-token amazon ?t) (known-id ?p) (of-type ?p ?pt) (sold-by ?p ?s) (seller-rating-known ?s) (top-rated-seller ?s ?pt) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?o ?p ?q ?c ?a) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?q - quantity ?c - payment-card ?a - address)
    :precondition (and (order-placed ?o ?p ?q ?c ?a) (not (task-completed)))
    :effect (task-completed))
)
