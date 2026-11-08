(define (domain appworld-59bcfc8-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number color product address addr-name street city state country zip-code payment-card - object
  )
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for-person ?q - query ?p - person)
    (product-query ?q - query)
    (known-phone ?p - person ?pn - phone-number)
    (known-home-address ?p - person ?addr - address)
    (address-parts ?addr - address ?n - addr-name ?st - street ?ci - city ?s - state ?co - country ?z - zip-code)
    (known-favorite-color ?p - person ?c - color)
    (found-product ?pr - product ?c - color)
    (product-selected ?pr - product)
    (cart-cleared)
    (in-cart ?pr - product)
    (gift-wrapped ?pr - product)
    (address-added ?addr - address)
    (known-id ?card - payment-card)
    (ordered ?pr - product ?addr - address)
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
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?pn - phone-number ?addr - address)
    :precondition (and (has-token phone ?t) (query-for-person ?q ?p) (not (task-completed)))
    :effect (and (known-phone ?p ?pn) (known-home-address ?p ?addr))
  )

  ; API: phone.search_voice_messages
  (:action phone-search-voice-messages
    :parameters (?t - token ?pn - phone-number ?p - person ?c - color)
    :precondition (and (has-token phone ?t) (known-phone ?p ?pn) (not (task-completed)))
    :effect (and (known-favorite-color ?p ?c))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?c - color ?pr - product ?p - person)
    :precondition (and (product-query ?q) (known-favorite-color ?p ?c) (not (task-completed)))
    :effect (and (found-product ?pr ?c) (product-selected ?pr))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token)
    :precondition (and (has-token amazon ?t) (product-selected ?pr) (cart-cleared) (not (task-completed)))
    :effect (and (in-cart ?pr))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?pr - product ?t - token)
    :precondition (and (has-token amazon ?t) (in-cart ?pr) (not (task-completed)))
    :effect (and (gift-wrapped ?pr))
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - addr-name ?st - street ?ci - city ?s - state ?co - country ?z - zip-code ?t - token ?addr - address ?p - person)
    :precondition (and (has-token amazon ?t) (known-home-address ?p ?addr) (address-parts ?addr ?n ?st ?ci ?s ?co ?z) (not (task-completed)))
    :effect (and (address-added ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?card))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?pr - product)
    :precondition (and (has-token amazon ?t) (known-id ?card) (address-added ?addr) (in-cart ?pr) (gift-wrapped ?pr) (not (task-completed)))
    :effect (and (ordered ?pr ?addr))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pr - product ?addr - address)
    :precondition (and (ordered ?pr ?addr) (gift-wrapped ?pr) (not (task-completed)))
    :effect (and (task-completed))
  )
)
