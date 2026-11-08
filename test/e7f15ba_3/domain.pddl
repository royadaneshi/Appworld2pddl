(define (domain appworld-e7f15ba-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship address
    addr-name street city state country zip-code
    product query quantity payment-card - object)
  (:constants amazon phone - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (relationship-of ?p - person ?r - relationship)
    (home-address-of ?p - person ?addr - address)
    (known-address ?addr - address)
    (address-fields ?addr - address ?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code)
    (known-address-id ?addr - address)
    (query-for ?prod - product ?q - query)
    (known-product-id ?prod - product)
    (wants-quantity ?prod - product ?qty - quantity)
    (cart-clear)
    (in-cart ?prod - product ?qty - quantity)
    (known-card-id ?card - payment-card)
    (order-placed ?addr - address)
    (task-completed))

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
    :parameters (?t - token ?r - relationship ?p - person ?addr - address)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (home-address-of ?p ?addr) (not (task-completed)))
    :effect (known-address ?addr))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-clear)) (not (task-completed)))
    :effect (cart-clear))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?prod - product)
    :precondition (and (query-for ?prod ?q) (not (known-product-id ?prod)) (not (task-completed)))
    :effect (known-product-id ?prod))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-product-id ?prod) (cart-clear) (wants-quantity ?prod ?qty) (not (in-cart ?prod ?qty)) (not (task-completed)))
    :effect (in-cart ?prod ?qty))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code ?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (known-address ?addr) (address-fields ?addr ?n ?s ?c ?st ?co ?z) (not (known-address-id ?addr)) (not (task-completed)))
    :effect (known-address-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (known-card-id ?card)) (not (task-completed)))
    :effect (known-card-id ?card))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p1 - product ?q1 - quantity ?p2 - product ?q2 - quantity ?p3 - product ?q3 - quantity)
    :precondition (and (has-token amazon ?t) (known-card-id ?card) (known-address-id ?addr) (cart-clear) (in-cart ?p1 ?q1) (in-cart ?p2 ?q2) (in-cart ?p3 ?q3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (and (order-placed ?addr) (not (in-cart ?p1 ?q1)) (not (in-cart ?p2 ?q2)) (not (in-cart ?p3 ?q3))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?addr - address)
    :precondition (and (order-placed ?addr) (not (task-completed)))
    :effect (task-completed))
)
