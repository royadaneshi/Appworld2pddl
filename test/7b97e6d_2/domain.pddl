(define (domain appworld-7b97e6d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product budget quantity order record - object
    payment-card address - record)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-known)
    (in-wish-list ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (budget-remaining ?b - budget)
    (price-fits ?p - product ?b1 - budget ?b2 - budget)
    (no-more-fits ?b - budget)
    (known-id ?r - record)
    (order-placed ?o - order)
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

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wish-list-known))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?b1 - budget ?b2 - budget)
    :precondition (and (has-token amazon ?t) (wish-list-known) (cart-cleared) (in-wish-list ?p) (not (in-cart ?p)) (budget-remaining ?b1) (price-fits ?p ?b1 ?b2) (not (task-completed)))
    :effect (and (in-cart ?p) (not (budget-remaining ?b1)) (budget-remaining ?b2)))

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
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?b - budget)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (cart-cleared) (budget-remaining ?b) (no-more-fits ?b) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (not (budget-remaining ?b))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order)
    :precondition (and (order-placed ?o) (not (task-completed)))
    :effect (task-completed)))
