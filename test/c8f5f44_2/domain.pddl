(define (domain appworld-c8f5f44-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email transaction query product quantity address payment-card comment order - object
  )
  (:constants supervisor phone venmo amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (person-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (sent-by ?tx - transaction ?p - person)
    (transaction-mentions ?tx - transaction ?q - query)
    (known-query ?q - query)
    (product-matches ?pr - product ?q - query)
    (known-id ?x)
    (cart-cleared)
    (in-cart ?pr - product ?qty - quantity)
    (home-address-known)
    (is-home-address ?addr - address)
    (order-placed ?o - order ?pr - product ?qty - quantity ?addr - address)
    (commented ?tx - transaction ?c - comment)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (person-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?p - person ?tx - transaction ?q - query)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (sent-by ?tx ?p) (transaction-mentions ?tx ?q) (not (task-completed)))
    :effect (and (known-id ?tx) (known-query ?q))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pr - product)
    :precondition (and (known-query ?q) (product-matches ?pr ?q) (not (task-completed)))
    :effect (known-id ?pr)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?pr) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?pr ?qty)
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (home-address-known)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (home-address-known) (is-home-address ?addr) (not (task-completed)))
    :effect (known-id ?addr)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?pr - product ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?pr ?qty) (not (task-completed)))
    :effect (and (order-placed ?o ?pr ?qty ?addr) (not (in-cart ?pr ?qty)))
  )

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?tx - transaction ?c - comment ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?tx) (not (task-completed)))
    :effect (commented ?tx ?c)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?qty - quantity ?addr - address ?tx - transaction ?c - comment)
    :precondition (and (order-placed ?o ?pr ?qty ?addr) (commented ?tx ?c) (not (task-completed)))
    :effect (task-completed)
  )
)
