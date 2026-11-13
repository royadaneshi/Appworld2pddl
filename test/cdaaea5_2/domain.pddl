(define (domain appworld-cdaaea5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query count entity - object
    note product address payment-card order list-item - entity)
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (note-for-query ?q - query ?n - note)
    (note-read ?n - note)
    (item-in-note ?i - list-item ?n - note)
    (query-for-item ?i - list-item ?q - query)
    (best-product ?i - list-item ?p - product)
    (found-best ?i - list-item ?p - product)
    (cart-cleared)
    (cart-locked)
    (in-cart ?p - product)
    (cart-count ?n - count)
    (count-succ ?n1 - count ?n2 - count)
    (list-size ?n - count)
    (is-work-address ?a - address)
    (order-placed ?o - order)
    (order-shipped-to ?o - order ?a - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-for-query ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-read ?n)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (cart-locked)) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?i - list-item ?n - note ?p - product)
    :precondition (and (query-for-item ?i ?q) (item-in-note ?i ?n) (note-read ?n) (best-product ?i ?p) (not (task-completed)))
    :effect (and (found-best ?i ?p) (known-id ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?n1 - count ?n2 - count)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (cart-locked)) (not (in-cart ?p)) (cart-count ?n1) (count-succ ?n1 ?n2) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-count ?n1)) (cart-count ?n2)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?n - count)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (cart-cleared) (not (cart-locked)) (cart-count ?n) (list-size ?n) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-shipped-to ?o ?a) (cart-locked)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?a - address)
    :precondition (and (order-placed ?o) (order-shipped-to ?o ?a) (is-work-address ?a) (not (task-completed)))
    :effect (and (task-completed)))
)
