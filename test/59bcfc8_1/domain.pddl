(define (domain appworld-59bcfc8-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number color product product-type quantity address address-name street city state country zipcode payment-card sort-key - object)
  (:constants phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (recipient ?p - person)
    (contact-query ?p - person ?q - query)
    (phone-of ?p - person ?n - phone-number)
    (home-address-of ?p - person ?addr - address)
    (favorite-color-of ?p - person ?c - color)
    (address-parts ?addr - address ?n - address-name ?st - street ?ci - city ?s - state ?co - country ?z - zipcode)
    (wanted-type ?pt - product-type)
    (search-query-for ?q - query ?pt - product-type)
    (rating-sort ?sk - sort-key)
    (highest-rated ?prod - product ?pt - product-type ?c - color)
    (known-phone ?p - person ?n - phone-number)
    (known-home-address ?p - person ?addr - address)
    (known-favorite-color ?p - person ?c - color)
    (found-product ?prod - product ?pt - product-type ?c - color)
    (cart-empty)
    (in-cart ?prod - product ?qty - quantity)
    (gift-wrapped ?prod - product ?qty - quantity)
    (address-added ?addr - address)
    (known-card ?card - payment-card)
    (order-placed ?prod - product ?addr - address))

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
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?addr - address)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-of ?p ?n) (home-address-of ?p ?addr) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-home-address ?p ?addr)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?c - color)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (favorite-color-of ?p ?c) (not (task-completed)))
    :effect (known-favorite-color ?p ?c))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?c - color ?sk - sort-key ?p - person ?prod - product)
    :precondition (and (recipient ?p) (known-favorite-color ?p ?c) (wanted-type ?pt) (search-query-for ?q ?pt) (rating-sort ?sk) (highest-rated ?prod ?pt ?c) (not (task-completed)))
    :effect (found-product ?prod ?pt ?c))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity ?pt - product-type ?c - color)
    :precondition (and (has-token amazon ?t) (found-product ?prod ?pt ?c) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?prod ?qty) (not (cart-empty))))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?prod ?qty) (not (task-completed)))
    :effect (gift-wrapped ?prod ?qty))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?st - street ?ci - city ?s - state ?co - country ?z - zipcode ?t - token ?addr - address ?p - person)
    :precondition (and (has-token amazon ?t) (recipient ?p) (known-home-address ?p ?addr) (address-parts ?addr ?n ?st ?ci ?s ?co ?z) (not (task-completed)))
    :effect (address-added ?addr))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card ?card))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?prod - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-card ?card) (address-added ?addr) (in-cart ?prod ?qty) (gift-wrapped ?prod ?qty) (not (task-completed)))
    :effect (order-placed ?prod ?addr))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?prod - product ?addr - address ?qty - quantity)
    :precondition (and (order-placed ?prod ?addr) (gift-wrapped ?prod ?qty) (not (task-completed)))
    :effect (task-completed))
)
