(define (domain appworld-4815c06-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product quantity payment-card address order - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (search-query-for ?p - product ?q - query)
    (known-id ?p - product)
    (wanted ?p - product)
    (original-entry ?p - product)
    (target-quantity ?p - product ?q - quantity)
    (in-cart ?p - product)
    (cart-cleared)
    (preferred-card ?c - payment-card)
    (known-card ?c - payment-card)
    (is-home-address ?ad - address)
    (known-address ?ad - address)
    (order-placed ?o - order)
    (order-contains ?o - order ?p - product)
    (order-paid-with ?o - order ?c - payment-card)
    (order-shipped-to ?o - order ?ad - address))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (original-entry ?p) (in-cart ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (search-query-for ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (original-entry ?p) (known-id ?p) (in-cart ?p) (not (cart-cleared)) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (cart-cleared)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (target-quantity ?p ?q) (cart-cleared) (not (in-cart ?p)) (not (task-completed)))
    :effect (and (in-cart ?p)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (preferred-card ?c) (not (task-completed)))
    :effect (and (known-card ?c)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?ad) (not (task-completed)))
    :effect (and (known-address ?ad)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?p1 - product ?p2 - product ?p3 - product ?po - product)
    :precondition (and (has-token amazon ?t) (known-card ?c) (preferred-card ?c) (known-address ?ad) (is-home-address ?ad) (not (order-placed ?o)) (wanted ?p1) (wanted ?p2) (wanted ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (in-cart ?p1) (in-cart ?p2) (in-cart ?p3) (original-entry ?po) (not (in-cart ?po)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-paid-with ?o ?c) (order-shipped-to ?o ?ad) (order-contains ?o ?p1) (order-contains ?o ?p2) (order-contains ?o ?p3) (not (in-cart ?p1)) (not (in-cart ?p2)) (not (in-cart ?p3))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?c - payment-card ?ad - address ?p1 - product ?p2 - product ?p3 - product ?po - product)
    :precondition (and (order-placed ?o) (order-paid-with ?o ?c) (preferred-card ?c) (order-shipped-to ?o ?ad) (is-home-address ?ad) (wanted ?p1) (wanted ?p2) (wanted ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (order-contains ?o ?p1) (order-contains ?o ?p2) (order-contains ?o ?p3) (not (in-cart ?p1)) (not (in-cart ?p2)) (not (in-cart ?p3)) (original-entry ?po) (in-cart ?po) (not (task-completed)))
    :effect (and (task-completed)))
)
