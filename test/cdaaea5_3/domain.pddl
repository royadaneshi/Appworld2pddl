(define (domain appworld-cdaaea5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query sort-key note shopping-item product quantity address payment-card count - object)
  (:constants simple-note amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?n - note)
    (note-search-query ?n - note ?q - query)
    (shopping-list-read)
    (query-for ?i - shopping-item ?q - query)
    (product-for-item ?i - shopping-item ?p - product)
    (best-product-found ?i - shopping-item ?p - product)
    (in-cart ?p - product)
    (item-carted ?i - shopping-item)
    (cart-count ?n - count)
    (succ ?n - count ?m - count)
    (required-count ?n - count)
    (known-address ?ad - address)
    (is-home-address ?ad - address)
    (known-payment-card ?c - payment-card)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-search-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (shopping-list-read)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?s - sort-key ?i - shopping-item ?p - product)
    :precondition (and (shopping-list-read) (query-for ?i ?q) (product-for-item ?i ?p) (not (task-completed)))
    :effect (and (best-product-found ?i ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?i - shopping-item ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (best-product-found ?i ?p) (not (item-carted ?i)) (not (in-cart ?p)) (cart-count ?n) (succ ?n ?m) (not (task-completed)))
    :effect (and (in-cart ?p) (item-carted ?i) (not (cart-count ?n)) (cart-count ?m)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-payment-card ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (known-payment-card ?c) (known-address ?ad) (is-home-address ?ad) (cart-count ?n) (required-count ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed)))
)
