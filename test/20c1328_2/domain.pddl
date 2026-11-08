(define (domain appworld-20c1328-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship count product-type price sort-key entity - object
    product address payment-card - entity
  )
  (:constants amazon phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (target-relationship ?r - relationship)
    (count-of-relationship ?r - relationship ?c - count)
    (known-count ?c - count)
    (target-product-type ?pt - product-type)
    (target-min-price ?pr - price)
    (target-max-price ?pr - price)
    (rating-sort ?s - sort-key)
    (known-id ?x - entity)
    (top-rated-in-range ?p - product)
    (home-address-known)
    (is-home-address ?addr - address)
    (cart-cleared)
    (in-cart ?p - product ?q - count)
    (ordered ?p - product ?q - count ?addr - address)
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
    :parameters (?t - token ?r - relationship ?c - count)
    :precondition (and (has-token phone ?t) (target-relationship ?r) (count-of-relationship ?r ?c) (not (task-completed)))
    :effect (known-count ?c)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?minp - price ?maxp - price ?sort - sort-key ?p - product)
    :precondition (and (target-product-type ?pt) (target-min-price ?minp) (target-max-price ?maxp) (rating-sort ?sort) (not (task-completed)))
    :effect (and (known-id ?p) (top-rated-in-range ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - count)
    :precondition (and (has-token amazon ?t) (known-id ?p) (top-rated-in-range ?p) (known-count ?q) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?p ?q)
  )

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (not (task-completed))
    :effect (home-address-known)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (home-address-known) (is-home-address ?addr) (not (task-completed)))
    :effect (known-id ?addr)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?card)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?q - count)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (is-home-address ?addr) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?addr) (not (in-cart ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - count ?addr - address)
    :precondition (and (ordered ?p ?q ?addr) (top-rated-in-range ?p) (is-home-address ?addr) (not (task-completed)))
    :effect (task-completed)
  )
)
