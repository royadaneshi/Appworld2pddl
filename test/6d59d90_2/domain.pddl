(define (domain appworld-6d59d90-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type sort-key day-limit quantity flag amount entity - object
    product card address - entity)
  (:constants amazon venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (max-delivery-days ?d - day-limit)
    (target-product ?p - product ?pt - product-type ?d - day-limit)
    (sorts-by-price ?s - sort-key)
    (single-unit ?q - quantity)
    (is-true ?f - flag)
    (in-cart ?p - product)
    (order-total-of ?p - product ?amt - amount)
    (known-amount ?amt - amount)
    (home-address ?a - address)
    (card-on-amazon ?c - card)
    (card-on-venmo ?c - card)
    (same-card ?ac - card ?vc - card)
    (funded ?c - card)
    (money-transferred)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?s - sort-key ?p - product ?d - day-limit)
    :precondition (and (sorts-by-price ?s) (max-delivery-days ?d) (target-product ?p ?pt ?d) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?f - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (single-unit ?q) (is-true ?f) (not (in-cart ?p)) (not (task-completed)))
    :effect (in-cart ?p))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?p - product ?amt - amount)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (order-total-of ?p ?amt) (not (task-completed)))
    :effect (known-amount ?amt))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address ?a) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (card-on-amazon ?c) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token venmo ?t) (card-on-venmo ?c) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?c - card ?t - token)
    :precondition (and (has-token venmo ?t) (known-amount ?amt) (known-id ?c) (card-on-venmo ?c) (not (funded ?c)) (not (task-completed)))
    :effect (and (funded ?c) (money-transferred)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?a - address ?t - token ?p - product ?vc - card)
    :precondition (and (has-token amazon ?t) (known-id ?c) (card-on-amazon ?c) (known-id ?a) (home-address ?a) (in-cart ?p) (same-card ?c ?vc) (funded ?vc) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (not (in-cart ?p))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (money-transferred) (order-placed) (not (task-completed)))
    :effect (task-completed))
)
