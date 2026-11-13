(define (domain appworld-cdaaea5-1)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person username password token query quantity item entity - object
    note product address payment-card - entity
  )
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (note-query ?n - note ?q - query)
    (shopping-list-known)
    (shopping-item ?i - item)
    (query-for ?i - item ?q - query)
    (product-for ?i - item ?p - product)
    (best-product-found ?i - item ?p - product)
    (cart-cleared)
    (in-cart ?p - product)
    (is-home ?ad - address)
    (order-placed)
    (ordered-to ?ad - address)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (shopping-list-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?i - item ?p - product)
    :precondition (and (shopping-list-known) (shopping-item ?i) (query-for ?i ?q) (product-for ?i ?p) (not (task-completed)))
    :effect (and (best-product-found ?i ?p) (known-id ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (in-cart ?p)) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (is-home ?ad) (not (task-completed)))
    :effect (and (known-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (is-home ?ad) (cart-cleared) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed) (ordered-to ?ad))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ad - address)
    :precondition (and (order-placed) (ordered-to ?ad) (forall (?p - product) (in-cart ?p)) (not (task-completed)))
    :effect (and (task-completed))
  )

)
