(define (domain appworld-7e1be84-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message
    product product-type quantity boolean payment-card address - object)
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (phone-of ?p - person ?ph - phone-number)
    (known-phone ?p - person ?ph - phone-number)
    (message-from ?p - person ?m - text-message)
    (message-query ?m - text-message ?q - query)
    (found-message ?m - text-message)
    (recommended-in ?m - text-message ?prod - product)
    (product-query ?prod - product ?q - query)
    (product-type-of ?prod - product ?pt - product-type)
    (known-id ?prod - product)
    (known-price ?prod - product)
    (cheaper-than ?p1 - product ?p2 - product)
    (known-card ?c - payment-card)
    (known-address ?a - address)
    (quantity-one ?qty - quantity)
    (is-true ?b - boolean)
    (in-cart ?prod - product ?qty - quantity)
    (ordered ?prod - product ?qty - quantity)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?ph - phone-number)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-of ?p ?ph) (not (task-completed)))
    :effect (known-phone ?p ?ph))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?q - query ?ph - phone-number ?p - person ?m - text-message)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (message-from ?p ?m) (message-query ?m ?q) (not (task-completed)))
    :effect (found-message ?m))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?prod - product ?m - text-message)
    :precondition (and (found-message ?m) (recommended-in ?m ?prod) (product-query ?prod ?q) (product-type-of ?prod ?pt) (not (task-completed)))
    :effect (and (known-id ?prod) (known-price ?prod)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-address ?a))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity ?clear - boolean ?other - product)
    :precondition (and (has-token amazon ?t) (known-id ?prod) (known-price ?prod) (known-price ?other) (cheaper-than ?prod ?other) (not (= ?prod ?other)) (quantity-one ?qty) (is-true ?clear) (not (task-completed)))
    :effect (in-cart ?prod ?qty))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?prod - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?a) (in-cart ?prod ?qty) (not (task-completed)))
    :effect (and (ordered ?prod ?qty) (not (in-cart ?prod ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?prod - product ?qty - quantity)
    :precondition (and (ordered ?prod ?qty) (quantity-one ?qty) (not (task-completed)))
    :effect (task-completed))
)
