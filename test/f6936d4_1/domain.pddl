(define (domain appworld-f6936d4-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type product quantity address payment-card - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (product-type-of ?p - product ?pt - product-type)
    (needs-quantity ?p - product ?q - quantity)
    (known-id ?p - product)
    (delivery-verified ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (known-address ?ad - address)
    (known-card ?c - payment-card)
    (order-placed)
    (ordered ?p - product ?q - quantity)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?p - product)
    :precondition (and (product-type-of ?p ?pt) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (delivery-verified ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (delivery-verified ?p) (needs-quantity ?p ?q) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p ?q)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p1 - product ?p2 - product ?q1 - quantity ?q2 - quantity)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?ad) (in-cart ?p1 ?q1) (in-cart ?p2 ?q2) (not (= ?p1 ?p2)) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (ordered ?p1 ?q1) (ordered ?p2 ?q2) (not (in-cart ?p1 ?q1)) (not (in-cart ?p2 ?q2))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - product ?p2 - product ?q1 - quantity ?q2 - quantity)
    :precondition (and (order-placed) (ordered ?p1 ?q1) (ordered ?p2 ?q2) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (and (task-completed))))
