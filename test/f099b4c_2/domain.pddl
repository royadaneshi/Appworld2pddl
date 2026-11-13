(define (domain appworld-f099b4c-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note product quantity amount - object)
  (:constants simple-note amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-note ?n - note)
    (list-read ?n - note)
    (on-list ?n - note ?p - product)
    (purchase-quantity ?p - product ?q - quantity)
    (known-availability ?p - product)
    (cart-cleared)
    (in-cart ?p - product ?q - quantity)
    (total-known)
    (found-total ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (not (task-completed)))
    :effect (found-note ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (found-note ?n) (not (task-completed)))
    :effect (list-read ?n))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared) (not (total-known))))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?n - note)
    :precondition (and (list-read ?n) (on-list ?n ?p) (not (task-completed)))
    :effect (known-availability ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (cart-cleared) (known-availability ?p) (purchase-quantity ?p ?q) (not (in-cart ?p ?q)) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (total-known))))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (cart-cleared) (not (task-completed)))
    :effect (and (found-total ?amt) (total-known)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (cart-cleared) (total-known) (found-total ?amt) (not (task-completed)))
    :effect (task-completed))
)
