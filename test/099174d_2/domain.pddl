(define (domain appworld-099174d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note product quantity address payment-card - object)
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (note-query ?q - query ?n - note)
    (shopping-list-note ?n - note)
    (shopping-list-known)
    (on-list ?p - product ?qty - quantity)
    (product-query ?p - product ?q - query)
    (cart-cleared)
    (added-to-cart ?p - product ?qty - quantity)
    (addresses-known)
    (cards-known)
    (note-delivery-address ?ad - address)
    (order-placed ?ad - address)
    (ordered)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (shopping-list-note ?n) (not (task-completed)))
    :effect (shopping-list-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (ordered)) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (shopping-list-known) (product-query ?p ?q) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (on-list ?p ?qty) (cart-cleared) (not (ordered)) (not (task-completed)))
    :effect (added-to-cart ?p ?qty))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-known))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cards-known))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (cards-known) (addresses-known) (shopping-list-known) (note-delivery-address ?ad) (cart-cleared) (not (ordered)) (not (task-completed)))
    :effect (and (ordered) (order-placed ?ad)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - product ?q1 - quantity ?p2 - product ?q2 - quantity ?ad - address)
    :precondition (and (added-to-cart ?p1 ?q1) (added-to-cart ?p2 ?q2) (not (= ?p1 ?p2)) (order-placed ?ad) (not (task-completed)))
    :effect (task-completed))
)
