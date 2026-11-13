(define (domain appworld-dc5c5c6-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship query product-type sort-key
    product payment-card address address-field quantity flag - object
  )
  (:constants supervisor phone amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (has-relationship ?p - person ?r - relationship)
    (contacts-found ?r - relationship)
    (home-name ?p - person ?f - address-field)
    (home-street ?p - person ?f - address-field)
    (home-city ?p - person ?f - address-field)
    (home-state ?p - person ?f - address-field)
    (home-country ?p - person ?f - address-field)
    (home-zip ?p - person ?f - address-field)
    (address-of ?p - person ?addr - address)
    (address-added ?addr - address)
    (top-rated-product ?pr - product)
    (known-card ?c - payment-card)
    (in-cart ?pr - product)
    (gift-wrapped ?pr - product)
    (ordered-for ?p - person)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (contacts-found ?r))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?s - sort-key ?pr - product)
    :precondition (and (not (task-completed)))
    :effect (and (top-rated-product ?pr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c))
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?name - address-field ?street - address-field ?city - address-field ?state - address-field ?country - address-field ?zip - address-field ?t - token ?addr - address ?p - person ?r - relationship)
    :precondition (and (has-token amazon ?t) (has-relationship ?p ?r) (contacts-found ?r)
                       (home-name ?p ?name) (home-street ?p ?street) (home-city ?p ?city)
                       (home-state ?p ?state) (home-country ?p ?country) (home-zip ?p ?zip)
                       (address-of ?p ?addr) (not (address-added ?addr)) (not (task-completed)))
    :effect (and (address-added ?addr))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (top-rated-product ?pr) (not (in-cart ?pr)) (not (task-completed)))
    :effect (and (in-cart ?pr))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?pr - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?pr) (not (gift-wrapped ?pr)) (not (task-completed)))
    :effect (and (gift-wrapped ?pr))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?pr - product ?p - person)
    :precondition (and (has-token amazon ?t) (known-card ?c) (address-added ?addr) (address-of ?p ?addr)
                       (top-rated-product ?pr) (in-cart ?pr) (gift-wrapped ?pr) (not (ordered-for ?p)) (not (task-completed)))
    :effect (and (ordered-for ?p) (not (in-cart ?pr)) (not (gift-wrapped ?pr)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (ordered-for ?p1) (ordered-for ?p2) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
