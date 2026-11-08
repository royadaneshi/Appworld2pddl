(define (domain appworld-f099b4c-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query - object
    note product quantity cost - object
  )
  (:constants amazon simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (on-list ?p - product ?n - note)
    (purchasable ?p - product ?q - quantity)
    (unavailable ?p - product)
    (availability-known ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (cart-cost-current)
    (found-total-cost ?c - cost)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (note-matches ?n ?q))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n))
    :effect (note-read ?n)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (cart-cleared)))
    :effect (and (cart-cleared) (not (cart-cost-current)))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?n - note)
    :precondition (and (not (task-completed)) (note-read ?n) (on-list ?p ?n))
    :effect (availability-known ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared) (availability-known ?p) (purchasable ?p ?q) (not (in-cart ?p ?q)))
    :effect (and (in-cart ?p ?q) (not (cart-cost-current)))
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?c - cost)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared))
    :effect (and (found-total-cost ?c) (cart-cost-current))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - cost)
    :precondition (and (not (task-completed)) (cart-cleared) (found-total-cost ?c) (cart-cost-current))
    :effect (task-completed)
  )
)
