(define (domain appworld-c8f5f44-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email transaction product query quantity flag address payment-card order comment - object
  )
  (:constants phone venmo amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-relationship ?p - person ?r - relationship)
    (person-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (transaction-from ?tx - transaction ?p - person)
    (transaction-for-product ?tx - transaction ?prod - product)
    (known-transaction ?tx - transaction)
    (found-requested-product ?prod - product)
    (product-query ?prod - product ?q - query)
    (known-product ?prod - product)
    (in-cart ?prod - product)
    (is-home-address ?addr - address)
    (home-address-known)
    (known-address ?addr - address)
    (known-payment-card ?card - payment-card)
    (order-placed ?o - order)
    (ordered ?o - order ?prod - product)
    (order-shipped-to ?o - order ?addr - address)
    (comment-posted ?tx - transaction ?c - comment)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (contact-relationship ?p ?r) (person-email ?p ?e))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?p - person ?tx - transaction ?prod - product)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (transaction-from ?tx ?p) (transaction-for-product ?tx ?prod))
    :effect (and (known-transaction ?tx) (found-requested-product ?prod))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?prod - product)
    :precondition (and (not (task-completed)) (found-requested-product ?prod) (product-query ?prod ?q))
    :effect (and (known-product ?prod))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-product ?prod))
    :effect (and (in-cart ?prod))
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (home-address-known))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (home-address-known) (is-home-address ?addr))
    :effect (and (known-address ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-payment-card ?card))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?prod - product ?o - order)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-payment-card ?card) (known-address ?addr) (in-cart ?prod) (not (order-placed ?o)))
    :effect (and (order-placed ?o) (ordered ?o ?prod) (order-shipped-to ?o ?addr) (not (in-cart ?prod)))
  )

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?tx - transaction ?c - comment ?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-transaction ?tx))
    :effect (and (comment-posted ?tx ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?prod - product ?addr - address ?tx - transaction ?c - comment)
    :precondition (and (not (task-completed)) (order-placed ?o) (ordered ?o ?prod) (order-shipped-to ?o ?addr) (is-home-address ?addr) (transaction-for-product ?tx ?prod) (comment-posted ?tx ?c))
    :effect (and (task-completed))
  )
)
