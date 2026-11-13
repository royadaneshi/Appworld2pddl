(define (domain appworld-dc5c5c6-2)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token relationship product-type sort-key
    recipient-name street city state country zip-code quantity flag address entity - object
    product payment-card - entity)
  (:constants amazon phone supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (sibling-relation ?rel - relationship)
    (siblings-located)
    (is-brother ?p - person)
    (home-address ?p - person ?addr - address)
    (address-recipient ?addr - address ?n - recipient-name)
    (address-street ?addr - address ?s - street)
    (address-city ?addr - address ?c - city)
    (address-state ?addr - address ?st - state)
    (address-country ?addr - address ?co - country)
    (address-zip ?addr - address ?z - zip-code)
    (top-rated-available ?prod - product ?pt - product-type)
    (sort-by-rating ?s - sort-key)
    (known-id ?x - entity)
    (availability-confirmed ?prod - product)
    (card-on-file ?card - payment-card)
    (quantity-one ?q - quantity)
    (true-flag ?f - flag)
    (address-added ?addr - address)
    (in-cart ?prod - product)
    (gift-wrapped ?prod - product)
    (gift-ordered ?p - person ?prod - product ?addr - address))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (passwords-known)) (not (task-completed)))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (has-token phone ?t) (sibling-relation ?rel)
                       (not (siblings-located)) (not (task-completed)))
    :effect (siblings-located))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?sort - sort-key ?prod - product)
    :precondition (and (top-rated-available ?prod ?pt) (sort-by-rating ?sort)
                       (not (known-id ?prod)) (not (task-completed)))
    :effect (known-id ?prod))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?prod - product)
    :precondition (and (known-id ?prod) (not (availability-confirmed ?prod)) (not (task-completed)))
    :effect (availability-confirmed ?prod))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (card-on-file ?card)
                       (not (known-id ?card)) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?name - recipient-name ?street - street ?city - city ?state - state
                 ?country - country ?zip - zip-code ?t - token ?p - person ?addr - address)
    :precondition (and (has-token amazon ?t) (siblings-located) (is-brother ?p)
                       (home-address ?p ?addr)
                       (address-recipient ?addr ?name) (address-street ?addr ?street)
                       (address-city ?addr ?city) (address-state ?addr ?state)
                       (address-country ?addr ?country) (address-zip ?addr ?zip)
                       (not (address-added ?addr)) (not (task-completed)))
    :effect (address-added ?addr))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?prod) (availability-confirmed ?prod)
                       (quantity-one ?qty) (true-flag ?clear)
                       (not (in-cart ?prod)) (not (task-completed)))
    :effect (in-cart ?prod))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?prod) (quantity-one ?qty)
                       (not (gift-wrapped ?prod)) (not (task-completed)))
    :effect (gift-wrapped ?prod))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - person ?prod - product)
    :precondition (and (has-token amazon ?t) (known-id ?card) (address-added ?addr)
                       (is-brother ?p) (home-address ?p ?addr)
                       (in-cart ?prod) (gift-wrapped ?prod)
                       (not (gift-ordered ?p ?prod ?addr)) (not (task-completed)))
    :effect (and (gift-ordered ?p ?prod ?addr) (not (in-cart ?prod)) (not (gift-wrapped ?prod))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?prod - product)
    :precondition (and (forall (?p - person ?a - address) (imply (home-address ?p ?a) (gift-ordered ?p ?prod ?a))) (not (task-completed)))
    :effect (task-completed))

)
