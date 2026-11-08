(define (domain appworld-b6d1f70-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token - object
    relationship product-type rating quantity flag - object
    product address payment-card wrap-status - object
    address-name street city state country zip-code - object
  )
  (:constants
    amazon phone - app
    wrapped unwrapped - wrap-status
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (has-relationship ?p - person ?r - relationship)
    (home-address-of ?p - person ?addr - address)
    (address-fields ?addr - address ?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code)
    (listed-in-amazon ?addr - address)
    (known-address-text ?addr - address)
    (known-address ?addr - address)
    (product-of-type ?p - product ?pt - product-type)
    (found-product ?p - product)
    (product-qualifies ?p - product)
    (known-card ?c - payment-card)
    (in-cart ?p - product)
    (cart-gift-wrap ?p - product ?w - wrap-status)
    (wrap-target ?w - wrap-status ?addr - address)
    (ordered ?p - product ?addr - address ?w - wrap-status)
    (order-placed ?w - wrap-status)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
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
    :parameters (?t - token ?rel - relationship ?p - person ?addr - address)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?rel) (home-address-of ?p ?addr) (not (task-completed)))
    :effect (known-address-text ?addr)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?mr - rating ?p - product)
    :precondition (and (product-of-type ?p ?pt) (not (task-completed)))
    :effect (found-product ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-product ?p) (not (task-completed)))
    :effect (product-qualifies ?p)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (listed-in-amazon ?addr) (not (task-completed)))
    :effect (known-address ?addr)
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code ?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (address-fields ?addr ?n ?s ?c ?st ?co ?z) (known-address-text ?addr) (not (listed-in-amazon ?addr)) (not (known-address ?addr)) (not (task-completed)))
    :effect (and (listed-in-amazon ?addr) (known-address ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card ?card)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (product-qualifies ?p) (not (in-cart ?p)) (not (task-completed)))
    :effect (and (in-cart ?p) (cart-gift-wrap ?p unwrapped))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (cart-gift-wrap ?p unwrapped) (not (task-completed)))
    :effect (and (cart-gift-wrap ?p wrapped) (not (cart-gift-wrap ?p unwrapped)))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?w - wrap-status)
    :precondition (and (has-token amazon ?t) (known-card ?card) (known-address ?addr) (in-cart ?p) (cart-gift-wrap ?p ?w) (wrap-target ?w ?addr) (not (order-placed ?w)) (not (task-completed)))
    :effect (and (ordered ?p ?addr ?w) (order-placed ?w) (not (in-cart ?p)) (not (cart-gift-wrap ?p ?w)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed wrapped) (order-placed unwrapped) (not (task-completed)))
    :effect (task-completed)
  )
)
