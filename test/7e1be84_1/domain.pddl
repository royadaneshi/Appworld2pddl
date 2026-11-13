(define (domain appworld-7e1be84-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message product quantity flag address payment-card order - object
  )
  (:constants phone amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (contact-number ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-from ?m - text-message ?p - person)
    (message-query ?m - text-message ?q - query)
    (found-message ?m - text-message)
    (recommends ?m - text-message ?pr - product)
    (known-price ?pr - product)
    (cheaper-than ?p1 - product ?p2 - product)
    (in-cart ?pr - product)
    (known-address-id ?ad - address)
    (known-card-id ?c - payment-card)
    (order-placed ?o - order ?pr - product)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (contact-number ?p ?n) (not (task-completed)))
    :effect (and (known-phone-number ?p ?n))
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?q - query ?n - phone-number ?p - person ?m - text-message)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (message-from ?m ?p) (message-query ?m ?q) (not (task-completed)))
    :effect (and (found-message ?m))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?pr - product ?m - text-message)
    :precondition (and (found-message ?m) (recommends ?m ?pr) (not (task-completed)))
    :effect (and (known-price ?pr))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?qty - quantity ?clear - flag ?other - product)
    :precondition (and (has-token amazon ?t) (known-price ?pr) (known-price ?other) (not (= ?pr ?other)) (cheaper-than ?pr ?other) (not (in-cart ?pr)) (not (task-completed)))
    :effect (and (in-cart ?pr))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?pr - product)
    :precondition (and (has-token amazon ?t) (known-card-id ?c) (known-address-id ?ad) (in-cart ?pr) (not (task-completed)))
    :effect (and (order-placed ?o ?pr) (not (in-cart ?pr)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product)
    :precondition (and (order-placed ?o ?pr) (not (task-completed)))
    :effect (and (task-completed))
  )
)
