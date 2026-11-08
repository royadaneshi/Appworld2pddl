(define (domain appworld-30e8586-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product quantity card address
    fullname street city state country zipcode duration - object)
  (:constants phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (product-query ?q - query)
    (unit-quantity ?q - quantity)
    (monthly ?d - duration)
    (known-home-address ?p - person)
    (address-name ?p - person ?n - fullname)
    (address-street ?p - person ?s - street)
    (address-city ?p - person ?c - city)
    (address-state ?p - person ?st - state)
    (address-country ?p - person ?co - country)
    (address-zip ?p - person ?z - zipcode)
    (address-of ?addr - address ?p - person)
    (address-added ?addr - address)
    (found-highest-rated ?prod - product)
    (known-card ?c - card)
    (prime-plans-known)
    (delivery-fee-known)
    (prime-needed)
    (prime-subscribed)
    (cart-empty)
    (cart-has-item)
    (in-cart ?prod - product ?p - person)
    (gift-wrapped ?prod - product ?p - person)
    (ordered ?p - person)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (not (task-completed)))
    :effect (known-home-address ?p)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?prod - product)
    :precondition (and (product-query ?q) (not (task-completed)))
    :effect (found-highest-rated ?prod)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-card ?c)
  )

  ; API: amazon.show_prime_plans
  (:action amazon-show-prime-plans
    :parameters ()
    :precondition (not (task-completed))
    :effect (prime-plans-known)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-has-item)) (not (task-completed)))
    :effect (cart-empty)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?q - quantity ?p - person)
    :precondition (and (has-token amazon ?t) (found-highest-rated ?prod) (unit-quantity ?q) (cart-empty) (not (ordered ?p)) (not (task-completed)))
    :effect (and (in-cart ?prod ?p) (cart-has-item) (not (cart-empty)))
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (cart-has-item) (not (task-completed)))
    :effect (delivery-fee-known)
  )

  ; API: amazon.subscribe_prime
  (:action amazon-subscribe-prime
    :parameters (?c - card ?d - duration ?t - token)
    :precondition (and (has-token amazon ?t) (known-card ?c) (monthly ?d) (delivery-fee-known) (prime-plans-known) (prime-needed) (not (prime-subscribed)) (not (task-completed)))
    :effect (and (prime-subscribed) (not (prime-needed)))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?prod - product ?t - token ?q - quantity ?p - person)
    :precondition (and (has-token amazon ?t) (in-cart ?prod ?p) (unit-quantity ?q) (not (gift-wrapped ?prod ?p)) (not (task-completed)))
    :effect (gift-wrapped ?prod ?p)
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - fullname ?s - street ?c - city ?st - state ?co - country ?z - zipcode ?t - token ?p - person ?addr - address)
    :precondition (and (has-token amazon ?t) (known-home-address ?p) (address-name ?p ?n) (address-street ?p ?s) (address-city ?p ?c) (address-state ?p ?st) (address-country ?p ?co) (address-zip ?p ?z) (address-of ?addr ?p) (not (address-added ?addr)) (not (task-completed)))
    :effect (address-added ?addr)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?addr - address ?t - token ?p - person ?prod - product)
    :precondition (and (has-token amazon ?t) (known-card ?c) (address-of ?addr ?p) (address-added ?addr) (in-cart ?prod ?p) (gift-wrapped ?prod ?p) (delivery-fee-known) (prime-plans-known) (not (prime-needed)) (not (ordered ?p)) (not (task-completed)))
    :effect (and (ordered ?p) (cart-empty) (not (cart-has-item)) (not (in-cart ?prod ?p)) (not (gift-wrapped ?prod ?p)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person ?p4 - person)
    :precondition (and (ordered ?p1) (ordered ?p2) (ordered ?p3) (ordered ?p4) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p1 ?p4)) (not (= ?p2 ?p3)) (not (= ?p2 ?p4)) (not (= ?p3 ?p4)) (not (task-completed)))
    :effect (task-completed)
  )
)
