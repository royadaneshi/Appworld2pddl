(define (domain appworld-099174d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note product quantity address payment-card order - object
  )
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (note-query ?n - note ?q - query)
    (note-read ?n - note)
    (listed-in ?p - product ?n - note)
    (product-query ?p - product ?q - query)
    (wanted-quantity ?p - product ?qty - quantity)
    (note-address ?n - note ?addr - address)
    (cart-cleared)
    (added-to-cart ?p - product ?qty - quantity)
    (addresses-listed)
    (payment-cards-listed)
    (checkout-done)
    (order-placed ?o - order)
    (order-address ?o - order ?addr - address)
    (ordered ?o - order ?p - product ?qty - quantity)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?n ?q) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (note-read ?n)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (checkout-done)) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product ?n - note)
    :precondition (and (note-read ?n) (listed-in ?p ?n) (product-query ?p ?q) (not (task-completed)))
    :effect (known-id ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?n - note)
    :precondition (and (has-token amazon ?t) (known-id ?p) (note-read ?n) (listed-in ?p ?n) (wanted-quantity ?p ?qty) (cart-cleared) (not (checkout-done)) (not (task-completed)))
    :effect (added-to-cart ?p ?qty)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-listed)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-cards-listed)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?o - order ?n - note ?p1 - product ?qty1 - quantity ?p2 - product ?qty2 - quantity)
    :precondition (and (has-token amazon ?t) (payment-cards-listed) (addresses-listed) (note-read ?n) (note-address ?n ?addr) (listed-in ?p1 ?n) (listed-in ?p2 ?n) (not (= ?p1 ?p2)) (added-to-cart ?p1 ?qty1) (added-to-cart ?p2 ?qty2) (cart-cleared) (not (checkout-done)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-address ?o ?addr) (ordered ?o ?p1 ?qty1) (ordered ?o ?p2 ?qty2) (checkout-done))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (checkout-done) (not (task-completed)))
    :effect (task-completed)
  )
)
