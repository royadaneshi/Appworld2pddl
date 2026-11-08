(define (domain appworld-ec655df-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread product quantity address payment-card flag - object
  )
  (:constants supervisor gmail amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (thread-matches ?q - query ?th - email-thread)
    (rsvp-count-of ?th - email-thread ?n - quantity)
    (rsvp-count-known ?n - quantity)
    (product-query ?q - query ?p - product)
    (is-true ?b - flag)
    (in-cart ?p - product ?n - quantity)
    (gift-wrapped ?p - product ?n - quantity)
    (home-address-text-known)
    (amazon-addresses-listed)
    (is-home-address ?addr - address)
    (order-placed ?p - product ?n - quantity ?addr - address)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (thread-matches ?q ?th))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?n - quantity)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (rsvp-count-of ?th ?n))
    :effect (and (rsvp-count-known ?n))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (not (task-completed)) (product-query ?q ?p))
    :effect (and (known-id ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?n - quantity ?b - flag)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?p) (rsvp-count-known ?n) (is-true ?b))
    :effect (and (in-cart ?p ?n))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?n - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (in-cart ?p ?n))
    :effect (and (gift-wrapped ?p ?n))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (home-address-text-known))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (amazon-addresses-listed))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?p - product ?n - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?c) (amazon-addresses-listed) (home-address-text-known) (is-home-address ?addr) (in-cart ?p ?n) (gift-wrapped ?p ?n))
    :effect (and (order-placed ?p ?n ?addr) (not (in-cart ?p ?n)) (not (gift-wrapped ?p ?n)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?n - quantity ?addr - address)
    :precondition (and (not (task-completed)) (order-placed ?p ?n ?addr) (is-home-address ?addr))
    :effect (and (task-completed))
  )
)
