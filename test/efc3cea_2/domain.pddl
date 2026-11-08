(define (domain appworld-efc3cea-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity flag entity - object
    email-thread product address payment-card - entity)
  (:constants gmail amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (thread-query ?th - email-thread ?q - query)
    (flight-confirmation ?th - email-thread)
    (found-weight-budget)
    (product-query ?p - product ?q - query)
    (found-weight-fits ?p - product)
    (found-giftable ?p - product)
    (in-cart ?p - product ?q - quantity)
    (gift-wrapped ?p - product ?q - quantity)
    (is-home-address ?ad - address)
    (order-placed ?p - product ?q - quantity ?ad - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-query ?th ?q) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?th) (flight-confirmation ?th) (not (task-completed)))
    :effect (found-weight-budget))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (product-query ?p ?q) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (found-weight-budget) (not (task-completed)))
    :effect (and (found-weight-fits ?p) (found-giftable ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?f - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (found-weight-fits ?p) (found-giftable ?p) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p ?q) (found-giftable ?p) (not (task-completed)))
    :effect (gift-wrapped ?p ?q))

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
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (is-home-address ?ad) (in-cart ?p ?q) (gift-wrapped ?p ?q) (not (task-completed)))
    :effect (order-placed ?p ?q ?ad))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?ad - address)
    :precondition (and (order-placed ?p ?q ?ad) (gift-wrapped ?p ?q) (not (task-completed)))
    :effect (task-completed))
)
