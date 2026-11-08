(define (domain appworld-9ef034e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number email product quantity address payment-card order amount payment-request - object)
  (:constants phone amazon venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (message-sender ?p - person)
    (contact-query ?p - person ?q - query)
    (contact-phone ?p - person ?ph - phone-number)
    (contact-email ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (known-email ?p - person ?e - email)
    (request-details-known)
    (requested ?prod - product ?qty - quantity)
    (product-query ?prod - product ?q - query)
    (known-id ?x - object)
    (cart-cleared)
    (in-cart ?prod - product ?qty - quantity)
    (home-address ?a - address)
    (order-placed ?o - order)
    (ordered ?o - order ?prod - product ?qty - quantity)
    (order-total ?o - order ?amt - amount)
    (known-total ?amt - amount)
    (request-sent ?r - payment-request)
    (request-to ?r - payment-request ?e - email)
    (request-amount ?r - payment-request ?amt - amount)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?q - query ?p - person ?ph - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (message-sender ?p) (contact-query ?p ?q) (contact-phone ?p ?ph) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?ph) (known-email ?p ?e)))

  (:action phone-search-text-messages
    ; API: phone.search_text_messages
    :parameters (?t - token ?ph - phone-number ?p - person)
    :precondition (and (has-token phone ?t) (message-sender ?p) (known-phone ?p ?ph) (not (task-completed)))
    :effect (request-details-known))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  (:action amazon-search-products
    ; API: amazon.search_products
    :parameters (?q - query ?prod - product)
    :precondition (and (request-details-known) (product-query ?prod ?q) (not (task-completed)))
    :effect (known-id ?prod))

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?prod) (request-details-known) (requested ?prod ?qty) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?prod ?qty))

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address ?a) (not (task-completed)))
    :effect (known-id ?a))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?prod - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (home-address ?a) (in-cart ?prod ?qty) (requested ?prod ?qty) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (ordered ?o ?prod ?qty) (known-id ?o)))

  (:action amazon-show-order
    ; API: amazon.show_order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (order-placed ?o) (known-id ?o) (order-total ?o ?amt) (not (task-completed)))
    :effect (known-total ?amt))

  (:action venmo-login
    ; API: venmo.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  (:action venmo-create-payment-request
    ; API: venmo.create_payment_request
    :parameters (?e - email ?amt - amount ?t - token ?r - payment-request ?p - person)
    :precondition (and (has-token venmo ?t) (message-sender ?p) (known-email ?p ?e) (known-total ?amt) (not (request-sent ?r)) (not (task-completed)))
    :effect (and (request-sent ?r) (request-to ?r ?e) (request-amount ?r ?amt)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?o - order ?r - payment-request)
    :precondition (and (order-placed ?o) (request-sent ?r) (not (task-completed)))
    :effect (task-completed))
)
