(define (domain appworld-c8f5f44-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship direction quantity comment entity - object
    product address payment-card transaction - entity
  )
  (:constants supervisor phone venmo amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (transaction-from ?tx - transaction ?p - person)
    (transaction-for ?tx - transaction ?prod - product)
    (known-id ?x - entity)
    (known-product-name ?prod - product)
    (query-for ?q - query ?prod - product)
    (home-address-known)
    (is-home-address ?a - address)
    (cart-cleared)
    (in-cart ?prod - product ?q - quantity)
    (ordered ?prod - product ?a - address)
    (commented ?tx - transaction ?c - comment)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (home-address-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - direction ?p - person ?tx - transaction ?prod - product)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (transaction-from ?tx ?p) (transaction-for ?tx ?prod) (not (task-completed)))
    :effect (and (known-id ?tx) (known-product-name ?prod))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?prod - product)
    :precondition (and (known-product-name ?prod) (query-for ?q ?prod) (not (task-completed)))
    :effect (and (known-id ?prod))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?prod) (cart-cleared) (not (task-completed)))
    :effect (and (in-cart ?prod ?q))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address-known) (is-home-address ?a) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?prod - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?prod ?q) (not (task-completed)))
    :effect (and (ordered ?prod ?addr) (not (in-cart ?prod ?q)))
  )

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?tx - transaction ?c - comment ?t - token)
    :precondition (and (has-token venmo ?t) (known-id ?tx) (not (commented ?tx ?c)) (not (task-completed)))
    :effect (and (commented ?tx ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?prod - product ?addr - address ?tx - transaction ?c - comment)
    :precondition (and (ordered ?prod ?addr) (is-home-address ?addr) (commented ?tx ?c) (transaction-for ?tx ?prod) (not (task-completed)))
    :effect (and (task-completed))
  )
)
