(define (domain appworld-9ef034e-1)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token query phone-number message product quantity address payment-card order amount email description - object)
  (:constants supervisor phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (contact-query ?p - person ?q - query)
    (phone-of ?p - person ?n - phone-number)
    (email-of ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (message-from ?m - message ?p - person)
    (message-read ?m - message)
    (requested ?m - message ?prod - product)
    (requested-quantity ?prod - product ?qty - quantity)
    (search-query ?prod - product ?q - query)
    (known-id ?x - object)
    (is-home-address ?addr - address)
    (in-cart ?prod - product ?qty - quantity)
    (order-placed ?o - order)
    (ordered ?prod - product ?qty - quantity)
    (ordered-to ?o - order ?addr - address)
    (total-of ?o - order ?amt - amount)
    (known-total ?o - order ?amt - amount)
    (payment-request-sent ?p - person ?amt - amount)
    (cart-cleared))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-of ?p ?n) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - message)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (message-from ?m ?p) (not (task-completed)))
    :effect (message-read ?m))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?m - message ?prod - product)
    :precondition (and (message-read ?m) (requested ?m ?prod) (search-query ?prod ?q) (not (task-completed)))
    :effect (known-id ?prod))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (cart-cleared) (known-id ?prod) (requested-quantity ?prod ?qty) (not (in-cart ?prod ?qty)) (not (task-completed)))
    :effect (in-cart ?prod ?qty))


  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?addr) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.place_order  (orders the whole cart: every requested product must be in it)
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (is-home-address ?addr)
                       (forall (?prod - product ?qty - quantity) (imply (requested-quantity ?prod ?qty) (in-cart ?prod ?qty)))
                       (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (known-id ?o) (ordered-to ?o ?addr)
                 (forall (?prod - product ?qty - quantity) (when (in-cart ?prod ?qty) (ordered ?prod ?qty)))))


  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-placed ?o) (total-of ?o ?amt) (not (task-completed)))
    :effect (known-total ?o ?amt))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-total ?o ?amt) (not (payment-request-sent ?p ?amt)) (not (task-completed)))
    :effect (payment-request-sent ?p ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?addr - address ?p - person ?amt - amount)
    :precondition (and (order-placed ?o) (ordered-to ?o ?addr) (known-total ?o ?amt) (payment-request-sent ?p ?amt) (not (task-completed)))
    :effect (task-completed))

)
