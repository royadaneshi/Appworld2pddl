(define (domain appworld-f6936d4-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type product quantity address payment-card - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for-type ?q - query ?pt - product-type)
    (product-of-type ?p - product ?pt - product-type)
    (needed-quantity ?pt - product-type ?qty - quantity)
    (is-home ?ad - address)
    (found-product ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?qty - quantity)
    (known-address ?ad - address)
    (known-card ?c - payment-card)
    (ordered ?p - product ?qty - quantity)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?p - product)
    :precondition (and (not (task-completed)) (query-for-type ?q ?pt) (product-of-type ?p ?pt) (not (found-product ?p)))
    :effect (and (found-product ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (cart-cleared)))
    :effect (and (cart-cleared)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?pt - product-type)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared) (found-product ?p) (product-of-type ?p ?pt) (needed-quantity ?pt ?qty) (not (in-cart ?p ?qty)))
    :effect (and (in-cart ?p ?qty)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (known-address ?ad)))
    :effect (and (known-address ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (known-card ?c)))
    :effect (and (known-card ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p1 - product ?q1 - quantity ?p2 - product ?q2 - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-card ?c) (known-address ?ad) (is-home ?ad) (in-cart ?p1 ?q1) (in-cart ?p2 ?q2) (not (= ?p1 ?p2)))
    :effect (and (ordered ?p1 ?q1) (ordered ?p2 ?q2) (not (in-cart ?p1 ?q1)) (not (in-cart ?p2 ?q2))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - product ?p2 - product ?qty - quantity)
    :precondition (and (not (task-completed)) (ordered ?p1 ?qty) (ordered ?p2 ?qty) (not (= ?p1 ?p2)))
    :effect (and (task-completed))))
