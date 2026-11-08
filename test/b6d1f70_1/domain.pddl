(define (domain appworld-b6d1f70-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query rating relationship address
    address-name street city state country zip order wrap quantity flag entity - object
    product address-id card - entity)
  (:constants amazon phone - app wrapped unwrapped - wrap)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (task-completed)
    (search-criteria ?q - query ?r - rating)
    (product-query ?p - product ?q - query)
    (rating-ok ?p - product)
    (reviews-ok ?p - product)
    (contact-address ?rel - relationship ?a - address)
    (found-address ?a - address)
    (addr-name ?a - address ?n - address-name)
    (addr-street ?a - address ?s - street)
    (addr-city ?a - address ?c - city)
    (addr-state ?a - address ?st - state)
    (addr-country ?a - address ?co - country)
    (addr-zip ?a - address ?z - zip)
    (address-for ?aid - address-id ?a - address)
    (amazon-listed ?aid - address-id)
    (unit-quantity ?qty - quantity)
    (true-flag ?f - flag)
    (in-cart ?p - product)
    (cart-wrap ?p - product ?g - wrap)
    (order-wrap ?o - order ?g - wrap)
    (order-destination ?o - order ?aid - address-id)
    (order-placed ?o - order ?p - product ?aid - address-id))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?minr - rating ?p - product)
    :precondition (and (search-criteria ?q ?minr) (product-query ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p) (rating-ok ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (reviews-ok ?p))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?aid - address-id)
    :precondition (and (has-token amazon ?t) (amazon-listed ?aid) (not (task-completed)))
    :effect (known-id ?aid))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?a - address)
    :precondition (and (has-token phone ?t) (contact-address ?rel ?a) (not (task-completed)))
    :effect (found-address ?a))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zip ?t - token ?a - address ?aid - address-id)
    :precondition (and (has-token amazon ?t) (found-address ?a) (addr-name ?a ?n) (addr-street ?a ?s) (addr-city ?a ?c) (addr-state ?a ?st) (addr-country ?a ?co) (addr-zip ?a ?z) (address-for ?aid ?a) (not (amazon-listed ?aid)) (not (known-id ?aid)) (not (task-completed)))
    :effect (known-id ?aid))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (rating-ok ?p) (reviews-ok ?p) (unit-quantity ?qty) (true-flag ?clear) (not (in-cart ?p)) (not (task-completed)))
    :effect (and (in-cart ?p) (cart-wrap ?p unwrapped)))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (cart-wrap ?p unwrapped) (not (task-completed)))
    :effect (and (not (cart-wrap ?p unwrapped)) (cart-wrap ?p wrapped)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?aid - address-id ?t - token ?o - order ?p - product ?g - wrap)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?aid) (in-cart ?p) (cart-wrap ?p ?g) (order-wrap ?o ?g) (order-destination ?o ?aid) (not (task-completed)))
    :effect (and (order-placed ?o ?p ?aid) (not (in-cart ?p)) (not (cart-wrap ?p ?g))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?o2 - order ?p - product ?a1 - address-id ?a2 - address-id)
    :precondition (and (order-placed ?o1 ?p ?a1) (order-placed ?o2 ?p ?a2) (not (= ?o1 ?o2)) (not (task-completed)))
    :effect (task-completed))
)
