(define (domain appworld-efc3cea-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread product-type product quantity flag address payment-card - object)
  (:constants gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (found-baggage-allowance)
    (product-details-known ?p - product)
    (in-cart ?p - product ?q - quantity)
    (gift-wrapped ?p - product ?q - quantity)
    (is-home-address ?a - address)
    (order-placed ?p - product ?q - quantity)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th))
    :effect (and (found-baggage-allowance)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (not (task-completed)) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?p - product)
    :precondition (and (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (not (task-completed)) (known-id ?p))
    :effect (and (product-details-known ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?p) (product-details-known ?p) (found-baggage-allowance) (not (in-cart ?p ?qty)))
    :effect (and (in-cart ?p ?qty)))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (in-cart ?p ?qty) (not (gift-wrapped ?p ?qty)))
    :effect (and (gift-wrapped ?p ?qty)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?a)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home-address ?a) (in-cart ?p ?qty) (gift-wrapped ?p ?qty) (not (order-placed ?p ?qty)))
    :effect (and (order-placed ?p ?qty) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?qty - quantity)
    :precondition (and (not (task-completed)) (order-placed ?p ?qty) (gift-wrapped ?p ?qty))
    :effect (and (task-completed)))
)
