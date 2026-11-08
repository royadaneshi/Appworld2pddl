(define (domain appworld-f3a6713-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity product-type - object
    entity - object
    email-thread product payment-card address - entity)
  (:constants
    supervisor gmail amazon - app
    remaining-item-1 remaining-item-2 remaining-item-3 - product-type)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (thread-query ?th - email-thread ?q - query)
    (found-remaining-items)
    (query-for ?pt - product-type ?q - query)
    (product-for ?pt - product-type ?p - product)
    (needed-quantity ?pt - product-type ?qty - quantity)
    (found-best-product ?pt - product-type ?p - product)
    (cart-cleared)
    (added-to-cart ?pt - product-type)
    (order-placed)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action gmail-login
    ; API: gmail.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  (:action gmail-show-outbox-threads
    ; API: gmail.show_outbox_threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-query ?th ?q) (not (task-completed)))
    :effect (known-id ?th))

  (:action gmail-show-thread
    ; API: gmail.show_thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?th) (not (task-completed)))
    :effect (found-remaining-items))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  (:action amazon-search-products
    ; API: amazon.search_products
    :parameters (?q - query ?pt - product-type ?p - product)
    :precondition (and (found-remaining-items) (query-for ?pt ?q) (product-for ?pt ?p) (not (task-completed)))
    :effect (and (known-id ?p) (found-best-product ?pt ?p)))

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared))

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?p - product ?t - token ?qty - quantity ?pt - product-type)
    :precondition (and (has-token amazon ?t) (cart-cleared) (known-id ?p) (found-best-product ?pt ?p) (needed-quantity ?pt ?qty) (not (added-to-cart ?pt)) (not (order-placed)) (not (task-completed)))
    :effect (added-to-cart ?pt))

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?a - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (added-to-cart remaining-item-1) (added-to-cart remaining-item-2) (added-to-cart remaining-item-3) (not (order-placed)) (not (task-completed)))
    :effect (order-placed))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters ()
    :precondition (and (order-placed) (added-to-cart remaining-item-1) (added-to-cart remaining-item-2) (added-to-cart remaining-item-3) (not (task-completed)))
    :effect (task-completed))
)
