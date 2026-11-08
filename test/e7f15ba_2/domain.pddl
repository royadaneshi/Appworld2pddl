(define (domain appworld-e7f15ba-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person relationship username password token query quantity address address-part order record - object
    product payment-card address-id - record)
  (:constants supervisor amazon phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (has-relationship ?p - person ?r - relationship)
    (home-address-of ?p - person ?addr - address)
    (known-address ?addr - address)
    (address-name-of ?addr - address ?x - address-part)
    (street-of ?addr - address ?x - address-part)
    (city-of ?addr - address ?x - address-part)
    (state-of ?addr - address ?x - address-part)
    (country-of ?addr - address ?x - address-part)
    (zip-of ?addr - address ?x - address-part)
    (address-on-amazon ?addr - address ?aid - address-id)
    (query-for ?p - product ?q - query)
    (known-id ?x - record)
    (wanted-quantity ?p - product ?q - quantity)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (checkout-done)
    (order-placed ?o - order ?aid - address-id))

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
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (home-address-of ?p ?addr) (not (task-completed)))
    :effect (known-address ?addr))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (query-for ?p ?q) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (wanted-quantity ?p ?qty) (not (in-cart ?p ?qty)) (not (checkout-done)) (not (task-completed)))
    :effect (in-cart ?p ?qty))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-part ?street - address-part ?city - address-part ?state - address-part ?country - address-part ?zip - address-part ?t - token ?addr - address ?aid - address-id)
    :precondition (and (has-token amazon ?t) (known-address ?addr) (address-name-of ?addr ?n) (street-of ?addr ?street) (city-of ?addr ?city) (state-of ?addr ?state) (country-of ?addr ?country) (zip-of ?addr ?zip) (not (known-id ?aid)) (not (task-completed)))
    :effect (and (address-on-amazon ?addr ?aid) (known-id ?aid)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?aid - address-id ?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?aid) (not (checkout-done)) (not (task-completed)))
    :effect (and (order-placed ?o ?aid) (checkout-done)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - product ?q1 - quantity ?p2 - product ?q2 - quantity ?p3 - product ?q3 - quantity ?o - order ?addr - address ?aid - address-id)
    :precondition (and (in-cart ?p1 ?q1) (in-cart ?p2 ?q2) (in-cart ?p3 ?q3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (address-on-amazon ?addr ?aid) (order-placed ?o ?aid) (not (task-completed)))
    :effect (task-completed))
)
