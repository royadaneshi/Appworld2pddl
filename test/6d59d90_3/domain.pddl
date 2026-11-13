(define (domain appworld-6d59d90-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type sort-key flag product amount card address - object)
  (:constants amazon venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (search-target ?pt - product-type ?s - sort-key ?p - product)
    (found-product ?p - product)
    (is-true ?f - flag)
    (in-cart ?p - product)
    (total-for ?p - product ?amt - amount)
    (known-amount ?amt - amount)
    (home-address ?ad - address)
    (known-address ?ad - address)
    (amazon-card ?c - card)
    (venmo-card ?c - card)
    (same-card ?ac - card ?vc - card)
    (known-id ?c - card)
    (card-funded ?c - card ?amt - amount)
    (order-placed ?p - product ?ad - address ?c - card))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?s - sort-key ?p - product)
    :precondition (and (search-target ?pt ?s ?p) (not (task-completed)))
    :effect (found-product ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?cf - flag)
    :precondition (and (found-product ?p) (has-token amazon ?t) (is-true ?cf) (not (task-completed)))
    :effect (in-cart ?p))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?p - product ?amt - amount)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (total-for ?p ?amt) (not (task-completed)))
    :effect (known-amount ?amt))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (home-address ?ad) (not (task-completed)))
    :effect (known-address ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (amazon-card ?c) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token venmo ?t) (venmo-card ?c) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?c - card ?t - token)
    :precondition (and (has-token venmo ?t) (known-amount ?amt) (known-id ?c) (venmo-card ?c) (not (task-completed)))
    :effect (card-funded ?c ?amt))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?ad - address ?t - token ?p - product ?vc - card ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?c) (amazon-card ?c) (known-address ?ad) (home-address ?ad) (in-cart ?p) (total-for ?p ?amt) (same-card ?c ?vc) (card-funded ?vc ?amt) (not (task-completed)))
    :effect (order-placed ?p ?ad ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?ad - address ?c - card ?vc - card ?amt - amount)
    :precondition (and (order-placed ?p ?ad ?c) (home-address ?ad) (same-card ?c ?vc) (card-funded ?vc ?amt) (total-for ?p ?amt) (not (task-completed)))
    :effect (task-completed))
)
