(define (domain appworld-30e8586-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type sort-key product quantity payment-card duration address address-name street city state country zipcode order - object)
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (query-for ?q - query ?p - person)
    (known-home-address ?p - person)
    (home-address-parts ?p - person ?n - address-name ?st - street ?c - city ?s - state ?co - country ?z - zipcode)
    (console-type ?pt - product-type)
    (rating-desc ?sb - sort-key)
    (found-top-rated ?prod - product)
    (known-delivery-fee ?prod - product)
    (known-prime-cost)
    (known-card ?card - payment-card)
    (monthly ?d - duration)
    (quantity-one ?qty - quantity)
    (prime-beneficial)
    (prime-handled)
    (prime-subscribed)
    (address-for ?addr - address ?p - person)
    (address-added ?addr - address)
    (in-cart ?prod - product)
    (gift-wrapped ?prod - product)
    (order-for ?o - order ?p - person)
    (order-placed ?o - order))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (not (task-completed)))
    :effect (and (known-home-address ?p)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?sb - sort-key ?prod - product)
    :precondition (and (console-type ?pt) (rating-desc ?sb) (not (task-completed)))
    :effect (and (found-top-rated ?prod)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?prod - product)
    :precondition (and (found-top-rated ?prod) (not (task-completed)))
    :effect (and (known-delivery-fee ?prod)))

  ; API: amazon.show_prime_plans
  (:action amazon-show-prime-plans
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (known-prime-cost)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?card)))

  ; API: amazon.subscribe_prime
  (:action amazon-subscribe-prime
    :parameters (?card - payment-card ?d - duration ?t - token ?prod - product)
    :precondition (and (has-token amazon ?t) (known-card ?card) (monthly ?d) (known-prime-cost) (found-top-rated ?prod) (known-delivery-fee ?prod) (prime-beneficial) (not (prime-handled)) (not (task-completed)))
    :effect (and (prime-subscribed) (prime-handled)))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?st - street ?c - city ?s - state ?co - country ?z - zipcode ?t - token ?addr - address ?p - person)
    :precondition (and (has-token amazon ?t) (known-home-address ?p) (home-address-parts ?p ?n ?st ?c ?s ?co ?z) (address-for ?addr ?p) (not (address-added ?addr)) (not (task-completed)))
    :effect (and (address-added ?addr)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (found-top-rated ?prod) (known-delivery-fee ?prod) (quantity-one ?qty) (not (in-cart ?prod)) (not (task-completed)))
    :effect (and (in-cart ?prod)))

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?prod - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?prod) (quantity-one ?qty) (not (gift-wrapped ?prod)) (not (task-completed)))
    :effect (and (gift-wrapped ?prod)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?o - order ?p - person ?prod - product)
    :precondition (and (has-token amazon ?t) (known-card ?card) (address-added ?addr) (address-for ?addr ?p) (order-for ?o ?p) (in-cart ?prod) (gift-wrapped ?prod) (known-prime-cost) (prime-handled) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (not (in-cart ?prod)) (not (gift-wrapped ?prod))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?o2 - order)
    :precondition (and (order-placed ?o1) (order-placed ?o2) (not (= ?o1 ?o2)) (prime-handled) (not (task-completed)))
    :effect (and (task-completed)))
)
