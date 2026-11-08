(define (domain appworld-7e1be84-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message product payment-card address order - object)
  (:constants phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (matches-query ?q - query ?p - person)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?n - phone-number)
    (message-from ?m - text-message ?n - phone-number)
    (found-message ?m - text-message)
    (mentions ?m - text-message ?prod - product)
    (known-price ?prod - product)
    (cheaper-than ?p1 - product ?p2 - product)
    (cart-empty)
    (in-cart ?prod - product)
    (known-id ?x)
    (ordered ?prod - product ?o - order)
    (task-completed))

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
    :parameters (?t - token ?q - query ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (matches-query ?q ?p) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (known-phone-number ?n))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?m - text-message)
    :precondition (and (has-token phone ?t) (known-phone-number ?n) (message-from ?m ?n) (not (task-completed)))
    :effect (found-message ?m))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?prod - product ?m - text-message)
    :precondition (and (found-message ?m) (mentions ?m ?prod) (not (task-completed)))
    :effect (known-price ?prod))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?other - product)
    :precondition (and (has-token amazon ?t) (cart-empty) (known-price ?prod) (known-price ?other) (not (= ?prod ?other)) (cheaper-than ?prod ?other) (not (task-completed)))
    :effect (and (in-cart ?prod) (not (cart-empty))))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?prod - product ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?prod) (not (task-completed)))
    :effect (and (ordered ?prod ?o) (not (in-cart ?prod)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?prod - product ?o - order)
    :precondition (and (ordered ?prod ?o) (not (task-completed)))
    :effect (task-completed))
)
