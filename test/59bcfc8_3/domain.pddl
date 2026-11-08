(define (domain appworld-59bcfc8-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number color product-type sort-key
    addr-name street city state country zipcode quantity order entity - object
    product address payment-card - entity)
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (contact-query ?p - person ?q - query)
    (phone-of ?p - person ?n - phone-number)
    (address-of ?p - person ?ad - address)
    (address-parts ?ad - address ?nm - addr-name ?st - street ?ci - city ?sa - state ?co - country ?zi - zipcode)
    (favorite-color-of ?p - person ?c - color)
    (known-phone ?n - phone-number)
    (known-address ?ad - address)
    (known-favorite-color ?p - person ?c - color)
    (product-type-of ?pr - product ?pt - product-type)
    (product-color ?pr - product ?c - color)
    (highest-rated ?pr - product)
    (sorts-by-rating-desc ?s - sort-key)
    (known-id ?x - entity)
    (cart-cleared)
    (in-cart ?pr - product ?qn - quantity)
    (gift-wrapped ?pr - product ?qn - quantity)
    (address-added ?ad - address)
    (order-placed ?o - order)
    (ordered ?o - order ?pr - product ?ad - address)
    (ordered-with-gift-wrap ?o - order))

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
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?ad - address)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-of ?p ?n) (address-of ?p ?ad) (not (task-completed)))
    :effect (and (known-phone ?n) (known-address ?ad)))

  ; API: phone.search_voice_messages
  (:action phone-search-voice-messages
    :parameters (?t - token ?n - phone-number ?p - person ?c - color)
    :precondition (and (has-token phone ?t) (known-phone ?n) (phone-of ?p ?n) (favorite-color-of ?p ?c) (not (task-completed)))
    :effect (known-favorite-color ?p ?c))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?c - color ?s - sort-key ?pr - product ?p - person)
    :precondition (and (known-favorite-color ?p ?c) (sorts-by-rating-desc ?s) (product-type-of ?pr ?pt) (product-color ?pr ?c) (highest-rated ?pr) (not (task-completed)))
    :effect (known-id ?pr))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?qn - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?pr) (cart-cleared) (not (in-cart ?pr ?qn)) (not (task-completed)))
    :effect (in-cart ?pr ?qn))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?pr - product ?t - token ?qn - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?pr ?qn) (not (task-completed)))
    :effect (gift-wrapped ?pr ?qn))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?nm - addr-name ?st - street ?ci - city ?sa - state ?co - country ?zi - zipcode ?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (known-address ?ad) (address-parts ?ad ?nm ?st ?ci ?sa ?co ?zi) (not (address-added ?ad)) (not (task-completed)))
    :effect (and (address-added ?ad) (known-id ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?ad - address ?t - token ?pr - product ?qn - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?ad) (address-added ?ad) (in-cart ?pr ?qn) (gift-wrapped ?pr ?qn) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (ordered ?o ?pr ?ad) (ordered-with-gift-wrap ?o) (not (in-cart ?pr ?qn)) (not (gift-wrapped ?pr ?qn))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?ad - address)
    :precondition (and (ordered ?o ?pr ?ad) (ordered-with-gift-wrap ?o) (not (task-completed)))
    :effect (task-completed)))
