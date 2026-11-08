(define (domain appworld-e7f15ba-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person token username password query quantity relationship addr-name street city state country zipcode - object
    entity - object
    product address payment-card - entity)
  (:constants amazon phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-for ?p - product ?q - query)
    (desired-quantity ?p - product ?q - quantity)
    (relationship-of ?p - person ?r - relationship)
    (home-address-of ?p - person ?addr - address)
    (address-parts ?addr - address ?n - addr-name ?st - street ?c - city ?s - state ?co - country ?z - zipcode)
    (known-address ?addr - address)
    (addresses-checked)
    (cart-cleared)
    (cart-has ?p - product ?q - quantity)
    (order-placed)
    (order-shipped-to ?addr - address)
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
    :parameters (?t - token ?r - relationship ?p - person ?addr - address)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (home-address-of ?p ?addr) (not (task-completed)))
    :effect (known-address ?addr))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (query-for ?p ?q) (not (known-id ?p)) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (desired-quantity ?p ?q) (cart-cleared) (not (cart-has ?p ?q)) (not (order-placed)) (not (task-completed)))
    :effect (cart-has ?p ?q))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-checked))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - addr-name ?st - street ?c - city ?s - state ?co - country ?z - zipcode ?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (known-address ?addr) (address-parts ?addr ?n ?st ?c ?s ?co ?z) (addresses-checked) (not (known-id ?addr)) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (known-id ?card)) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (order-shipped-to ?addr)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - product ?q1 - quantity ?p2 - product ?q2 - quantity ?p3 - product ?q3 - quantity ?addr - address)
    :precondition (and (cart-has ?p1 ?q1) (cart-has ?p2 ?q2) (cart-has ?p3 ?q3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (order-placed) (order-shipped-to ?addr) (not (task-completed)))
    :effect (task-completed))
)
