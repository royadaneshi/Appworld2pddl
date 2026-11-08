(define (domain appworld-20c1328-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship quantity
    product-type price sort-key product address payment-card - object)
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (roommate-count-known ?q - quantity)
    (search-spec ?pt - product-type ?minp - price ?maxp - price ?s - sort-key)
    (found-product ?p - product)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (known-address ?ad - address)
    (known-card ?c - payment-card)
    (ordered ?p - product ?q - quantity ?ad - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (login-username phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?q - quantity)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (roommate-count-known ?q)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (login-username amazon ?u) (password-for amazon ?pw)
                       (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?minp - price ?maxp - price ?s - sort-key ?p - product)
    :precondition (and (search-spec ?pt ?minp ?maxp ?s) (not (task-completed)))
    :effect (and (found-product ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-empty)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (found-product ?p) (roommate-count-known ?q)
                       (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (cart-empty))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?ad)
                       (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?ad) (not (in-cart ?p ?q)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?ad - address)
    :precondition (and (ordered ?p ?q ?ad) (not (task-completed)))
    :effect (and (task-completed)))
)
