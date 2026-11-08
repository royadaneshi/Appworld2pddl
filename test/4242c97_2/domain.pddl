(define (domain appworld-4242c97-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query size color product quantity flag payment-card address order - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (is-supervisor ?p - person)
    (named-by ?p - product ?q - query)
    (sweater-variant ?p - product ?c - color ?s - size)
    (next-preferred-color ?c - color ?next - color)
    (may-search ?c - color)
    (checked ?c - color)
    (availability-known ?p - product)
    (is-true ?f - flag)
    (in-cart ?p - product ?qty - quantity)
    (order-placed ?o - order)
    (ordered ?o - order ?p - product ?qty - quantity)
    (ordered-sweater ?o - order ?s - size ?qty - quantity)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  ; search the sweater name filtered by color and relative_size; colors may only be tried in preference order
  (:action amazon-search-products
    :parameters (?q - query ?c - color ?s - size ?p - product ?next - color)
    :precondition (and (named-by ?p ?q) (sweater-variant ?p ?c ?s) (may-search ?c) (next-preferred-color ?c ?next) (not (task-completed)))
    :effect (and (checked ?c) (known-id ?p) (may-search ?next)))

  ; API: amazon.show_product
  ; verify that the found variant is available (in stock, right color and size)
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (availability-known ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (availability-known ?p) (is-true ?clear) (not (task-completed)))
    :effect (in-cart ?p ?qty))

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
    :parameters (?card - payment-card ?addr - address ?t - token ?p - product ?c - color ?s - size ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?addr) (in-cart ?p ?qty) (sweater-variant ?p ?c ?s) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (ordered ?o ?p ?qty) (ordered-sweater ?o ?s ?qty) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?s - size ?qty - quantity)
    :precondition (and (order-placed ?o) (ordered-sweater ?o ?s ?qty) (not (task-completed)))
    :effect (task-completed))
)
