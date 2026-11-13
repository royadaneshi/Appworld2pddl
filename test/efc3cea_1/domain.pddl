(define (domain appworld-efc3cea-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread product-type product quantity flag record - object
    address payment-card - record
  )
  (:constants supervisor gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (thread-matches ?q - query ?th - email-thread)
    (flight-confirmation ?th - email-thread)
    (found-thread ?th - email-thread)
    (weight-limit-known)
    (product-has-type ?p - product ?pt - product-type)
    (found-product ?p - product)
    (product-details-known ?p - product)
    (within-weight-budget ?p - product)
    (gift-wrappable ?p - product)
    (target-quantity ?q - quantity)
    (in-cart ?p - product ?q - quantity)
    (gift-wrapped-in-cart ?p - product ?q - quantity)
    (known-id ?r - record)
    (is-home-address ?addr - address)
    (ordered ?p - product ?q - quantity)
    (ordered-gift-wrapped ?p - product ?q - quantity)
    (shipped-to ?addr - address)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (found-thread ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (found-thread ?th) (flight-confirmation ?th) (not (task-completed)))
    :effect (weight-limit-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?p - product)
    :precondition (and (product-has-type ?p ?pt) (not (task-completed)))
    :effect (found-product ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-product ?p) (not (task-completed)))
    :effect (product-details-known ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (product-details-known ?p) (weight-limit-known) (within-weight-budget ?p) (gift-wrappable ?p) (target-quantity ?q) (not (task-completed)))
    :effect (in-cart ?p ?q)
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p ?q) (gift-wrappable ?p) (not (task-completed)))
    :effect (gift-wrapped-in-cart ?p ?q)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?addr)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (is-home-address ?addr) (in-cart ?p ?q) (gift-wrapped-in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q) (ordered-gift-wrapped ?p ?q) (shipped-to ?addr) (not (in-cart ?p ?q)) (not (gift-wrapped-in-cart ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?addr - address)
    :precondition (and (ordered ?p ?q) (ordered-gift-wrapped ?p ?q) (shipped-to ?addr) (not (task-completed)))
    :effect (task-completed)
  )
)
