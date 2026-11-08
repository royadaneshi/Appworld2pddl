(define (domain appworld-f099b4c-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity amount entity - object
    note product - entity)
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (note-matches ?q - query ?n - note)
    (is-shopping-list ?n - note)
    (shopping-list-known)
    (product-query ?p - product ?q - query)
    (availability-known ?p - product)
    (purchasable ?p - product ?q - quantity)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (cart-total-known)
    (cart-total ?c - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
      (username-for simple-note ?u) (password-for simple-note ?pw)
      (token-of simple-note ?t) (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t)
      (note-matches ?q ?n) (not (known-id ?n)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t)
      (known-id ?n) (is-shopping-list ?n) (not (shopping-list-known)))
    :effect (shopping-list-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
      (username-for amazon ?u) (password-for amazon ?pw)
      (token-of amazon ?t) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (not (task-completed)) (shopping-list-known)
      (product-query ?p ?q) (not (known-id ?p)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (not (task-completed)) (known-id ?p) (not (availability-known ?p)))
    :effect (availability-known ?p))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (cart-cleared)))
    :effect (and (cart-cleared) (not (cart-total-known))))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared)
      (availability-known ?p) (purchasable ?p ?q) (not (in-cart ?p ?q)))
    :effect (and (in-cart ?p ?q) (not (cart-total-known))))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared)
      (not (cart-total-known)))
    :effect (cart-total-known))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - amount)
    :precondition (and (not (task-completed)) (cart-cleared) (cart-total-known) (cart-total ?c))
    :effect (task-completed))
)
