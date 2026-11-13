(define (domain appworld-ec655df-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity order entity - object
    email-thread product address payment-card - entity
  )
  (:constants supervisor gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (thread-query ?qry - query ?th - email-thread)
    (rsvp-count-of ?th - email-thread ?q - quantity)
    (found-rsvp-count ?q - quantity)
    (product-query ?qry - query ?p - product)
    (target-product ?p - product)
    (home-address ?ad - address)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (gift-wrapped ?p - product ?q - quantity)
    (ordered ?o - order ?p - product ?q - quantity ?ad - address)
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
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?qry - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-query ?qry ?th) (not (task-completed)))
    :effect (known-id ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - quantity)
    :precondition (and (has-token gmail ?t) (known-id ?th) (rsvp-count-of ?th ?q) (not (task-completed)))
    :effect (found-rsvp-count ?q)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?qry - query ?p - product)
    :precondition (and (product-query ?qry ?p) (not (task-completed)))
    :effect (known-id ?p)
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
    :precondition (and (has-token amazon ?t) (known-id ?p) (target-product ?p) (found-rsvp-count ?q) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (cart-empty)))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p ?q) (not (task-completed)))
    :effect (gift-wrapped ?p ?q)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (home-address ?ad) (not (task-completed)))
    :effect (known-id ?ad)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (home-address ?ad) (in-cart ?p ?q) (gift-wrapped ?p ?q) (not (ordered ?o ?p ?q ?ad)) (not (task-completed)))
    :effect (and (ordered ?o ?p ?q ?ad) (not (in-cart ?p ?q)) (not (gift-wrapped ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?q - quantity ?ad - address)
    :precondition (and (ordered ?o ?p ?q ?ad) (target-product ?p) (found-rsvp-count ?q) (home-address ?ad) (not (task-completed)))
    :effect (task-completed)
  )
)
