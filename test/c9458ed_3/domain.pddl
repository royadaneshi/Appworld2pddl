(define (domain appworld-c9458ed-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship promo-code flag entity - object
    product payment-card address - entity)
  (:constants
    amazon phone - app
    sibling coworker - relationship)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contacts-known ?r - relationship)
    (replies-checked ?r - relationship)
    (product-query ?q - query ?p - product)
    (known-id ?x - entity)
    (in-cart ?p - product)
    (promo-applied ?c - promo-code)
    (discount-verified ?c - promo-code)
    (order-placed ?p - product ?c - promo-code)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-known ?r))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (contacts-known ?r) (not (task-completed)))
    :effect (replies-checked ?r))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (product-query ?q ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (not (in-cart ?p)) (not (task-completed)))
    :effect (in-cart ?p))

  ; API: amazon.apply_promo_code_to_cart
  (:action amazon-apply-promo-code-to-cart
    :parameters (?c - promo-code ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (replies-checked sibling) (replies-checked coworker) (not (task-completed)))
    :effect (promo-applied ?c))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?c - promo-code)
    :precondition (and (has-token amazon ?t) (promo-applied ?c) (not (task-completed)))
    :effect (discount-verified ?c))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?addr))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?c - promo-code)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?p) (promo-applied ?c) (discount-verified ?c) (not (task-completed)))
    :effect (and (order-placed ?p ?c) (not (in-cart ?p))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?c - promo-code)
    :precondition (and (order-placed ?p ?c) (not (task-completed)))
    :effect (task-completed))
)
