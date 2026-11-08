(define (domain appworld-dc5c5c6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship
    product-type sort-key product payment-card
    address contact-name street city state country zip-code
    quantity flag - object)
  (:constants amazon phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (sibling-relationship ?r - relationship)
    (siblings-found)
    (is-sibling ?p - person)
    (home-address-of ?p - person ?addr - address)
    (addr-name ?addr - address ?n - contact-name)
    (addr-street ?addr - address ?s - street)
    (addr-city ?addr - address ?c - city)
    (addr-state ?addr - address ?st - state)
    (addr-country ?addr - address ?co - country)
    (addr-zip ?addr - address ?z - zip-code)
    (product-of-type ?prod - product ?pt - product-type)
    (top-rated-available ?prod - product)
    (known-product ?prod - product)
    (known-card ?card - payment-card)
    (address-added ?addr - address)
    (in-cart ?prod - product)
    (gift-wrapped ?prod - product)
    (gift-ordered ?p - person ?prod - product))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (token-of phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (sibling-relationship ?r) (not (task-completed)))
    :effect (and (siblings-found)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (token-of amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?sk - sort-key ?prod - product)
    :precondition (and (product-of-type ?prod ?pt) (top-rated-available ?prod) (not (task-completed)))
    :effect (and (known-product ?prod)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?card)))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?name - contact-name ?street - street ?city - city ?state - state ?country - country ?zip - zip-code ?t - token ?p - person ?addr - address)
    :precondition (and (has-token amazon ?t) (siblings-found) (is-sibling ?p)
                       (home-address-of ?p ?addr)
                       (addr-name ?addr ?name) (addr-street ?addr ?street) (addr-city ?addr ?city)
                       (addr-state ?addr ?state) (addr-country ?addr ?country) (addr-zip ?addr ?zip)
                       (not (address-added ?addr)) (not (task-completed)))
    :effect (and (address-added ?addr)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-product ?prod) (not (in-cart ?prod)) (not (task-completed)))
    :effect (and (in-cart ?prod)))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?prod) (not (gift-wrapped ?prod)) (not (task-completed)))
    :effect (and (gift-wrapped ?prod)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - person ?prod - product)
    :precondition (and (has-token amazon ?t) (known-card ?card) (address-added ?addr)
                       (is-sibling ?p) (home-address-of ?p ?addr)
                       (in-cart ?prod) (gift-wrapped ?prod)
                       (not (gift-ordered ?p ?prod)) (not (task-completed)))
    :effect (and (gift-ordered ?p ?prod) (not (in-cart ?prod)) (not (gift-wrapped ?prod))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?prod - product)
    :precondition (and (gift-ordered ?p1 ?prod) (gift-ordered ?p2 ?prod) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (and (task-completed))))
