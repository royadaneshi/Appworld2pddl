(define (domain appworld-23d431c-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query price seller product-type quantity entity - object
    product address payment-card - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (found ?p - product)
    (purchased-before ?p - product)
    (sold-by ?p - product ?s - seller)
    (known-trusted-seller ?s - seller)
    (product-type-of ?p - product ?pt - product-type)
    (wanted-type ?pt - product-type)
    (query-for ?q - query ?pt - product-type)
    (budget ?mp - price)
    (price-at-most ?p - product ?mp - price)
    (is-one ?qty - quantity)
    (cart-cleared)
    (in-cart ?p - product ?qty - quantity)
    (ordered ?p - product ?qty - quantity)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  (:action amazon-show-product-purchases
    ; API: amazon.show_product_purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (purchased-before ?p) (not (task-completed)))
    :effect (known-id ?p))

  (:action amazon-show-product
    ; API: amazon.show_product
    :parameters (?p - product ?s - seller)
    :precondition (and (known-id ?p) (purchased-before ?p) (sold-by ?p ?s) (not (task-completed)))
    :effect (known-trusted-seller ?s))

  (:action amazon-search-products
    ; API: amazon.search_products
    :parameters (?q - query ?mp - price ?s - seller ?p - product ?pt - product-type)
    :precondition (and (known-trusted-seller ?s) (wanted-type ?pt) (query-for ?q ?pt) (budget ?mp) (product-type-of ?p ?pt) (price-at-most ?p ?mp) (sold-by ?p ?s) (not (task-completed)))
    :effect (found ?p))

  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  (:action amazon-clear-cart
    ; API: amazon.clear_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (cart-cleared))

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (found ?p) (has-token amazon ?t) (cart-cleared) (is-one ?qty) (not (task-completed)))
    :effect (in-cart ?p ?qty))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?qty - quantity)
    :precondition (and (known-id ?c) (known-id ?ad) (has-token amazon ?t) (in-cart ?p ?qty) (not (task-completed)))
    :effect (and (ordered ?p ?qty) (not (in-cart ?p ?qty))))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?p - product ?qty - quantity)
    :precondition (and (ordered ?p ?qty) (is-one ?qty) (not (task-completed)))
    :effect (task-completed)))
