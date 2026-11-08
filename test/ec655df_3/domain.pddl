(define (domain appworld-ec655df-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread product quantity address payment-card - object)
  (:constants supervisor gmail amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (thread-query ?qr - query ?th - email-thread)
    (rsvp-count-of ?th - email-thread ?q - quantity)
    (product-query ?qr - query ?p - product)
    (home-address-of ?per - person ?ad - address)
    (rsvp-thread-found ?th - email-thread)
    (rsvp-count-known ?q - quantity)
    (known-id ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (gift-wrapped ?p - product ?q - quantity)
    (home-address-known ?ad - address)
    (known-address-id ?ad - address)
    (known-card-id ?c - payment-card)
    (order-placed ?p - product ?q - quantity ?ad - address))

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
    :parameters (?t - token ?qr - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-query ?qr ?th) (not (task-completed)))
    :effect (rsvp-thread-found ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - quantity)
    :precondition (and (has-token gmail ?t) (rsvp-thread-found ?th) (rsvp-count-of ?th ?q) (not (task-completed)))
    :effect (rsvp-count-known ?q))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?qr - query ?p - product)
    :precondition (and (product-query ?qr ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (rsvp-count-known ?q) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p ?q) (not (task-completed)))
    :effect (gift-wrapped ?p ?q))

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters (?per - person ?ad - address)
    :precondition (and (home-address-of ?per ?ad) (not (task-completed)))
    :effect (home-address-known ?ad))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (home-address-known ?ad) (not (task-completed)))
    :effect (known-address-id ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-card-id ?c) (known-address-id ?ad) (in-cart ?p ?q) (gift-wrapped ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?q ?ad) (not (in-cart ?p ?q)) (not (gift-wrapped ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?ad - address)
    :precondition (and (order-placed ?p ?q ?ad) (not (task-completed)))
    :effect (task-completed))
)
