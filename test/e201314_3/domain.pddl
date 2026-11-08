(define (domain appworld-e201314-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship rating product quantity flag record - object
    address payment-card - record)
  (:constants
    phone amazon supervisor - app
    coworker roommate - relationship)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contacts-known ?r - relationship)
    (invitee-count ?qty - quantity)
    (product-query ?p - product ?q - query)
    (min-rating ?r - rating)
    (product-found ?p - product)
    (product-verified ?p - product)
    (in-cart ?p - product ?qty - quantity)
    (is-home-address ?a - address)
    (known-id ?x - record)
    (ordered ?p - product ?qty - quantity ?a - address)
    (task-completed))

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
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-known ?r))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?r - rating ?p - product)
    :precondition (and (product-query ?p ?q) (min-rating ?r) (not (task-completed)))
    :effect (product-found ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (product-found ?p) (not (task-completed)))
    :effect (product-verified ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (product-verified ?p) (invitee-count ?qty) (contacts-known coworker) (contacts-known roommate) (not (task-completed)))
    :effect (in-cart ?p ?qty))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?a) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home-address ?a) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (ordered ?p ?qty ?a) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?qty - quantity ?a - address)
    :precondition (and (ordered ?p ?qty ?a) (invitee-count ?qty) (is-home-address ?a) (not (task-completed)))
    :effect (task-completed)))
