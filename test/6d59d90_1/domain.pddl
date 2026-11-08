(define (domain appworld-6d59d90-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product flag amount address amazon-card venmo-card - object)
  (:constants amazon venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (product-query ?p - product ?q - query)
    (found-product ?p - product)
    (in-cart ?p - product)
    (cart-total-of ?p - product ?amt - amount)
    (known-total ?amt - amount)
    (home-address ?addr - address)
    (known-address-id ?addr - address)
    (known-amazon-card-id ?ac - amazon-card)
    (known-venmo-card-id ?vc - venmo-card)
    (same-card ?ac - amazon-card ?vc - venmo-card)
    (transferred-to-card ?amt - amount ?vc - venmo-card)
    (card-funded ?ac - amazon-card)
    (order-placed ?p - product ?addr - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-of amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (product-query ?p ?q) (not (task-completed)))
    :effect (found-product ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?cf - flag)
    :precondition (and (has-token amazon ?t) (found-product ?p) (not (task-completed)))
    :effect (in-cart ?p))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?p - product ?amt - amount)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (cart-total-of ?p ?amt) (not (task-completed)))
    :effect (known-total ?amt))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (home-address ?addr) (not (task-completed)))
    :effect (known-address-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?ac - amazon-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-amazon-card-id ?ac))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-of venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?vc - venmo-card)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (known-venmo-card-id ?vc))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?vc - venmo-card ?t - token ?ac - amazon-card)
    :precondition (and (has-token venmo ?t) (known-total ?amt) (known-venmo-card-id ?vc) (same-card ?ac ?vc) (not (task-completed)))
    :effect (and (transferred-to-card ?amt ?vc) (card-funded ?ac)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?ac - amazon-card ?addr - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-amazon-card-id ?ac) (card-funded ?ac) (known-address-id ?addr) (home-address ?addr) (in-cart ?p) (not (task-completed)))
    :effect (order-placed ?p ?addr))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?addr - address ?amt - amount ?vc - venmo-card)
    :precondition (and (order-placed ?p ?addr) (transferred-to-card ?amt ?vc) (not (task-completed)))
    :effect (task-completed))
)
