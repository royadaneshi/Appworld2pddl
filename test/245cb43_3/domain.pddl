(define (domain appworld-245cb43-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product record - object
    payment-card address - record
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-wish-list ?p - product)
    (is-compass ?p - product)
    (fits-pocket ?p - product)
    (wish-list-known)
    (known-dimensions ?p - product)
    (cart-empty)
    (in-cart ?p - product)
    (owns-card ?c - payment-card)
    (owns-address ?ad - address)
    (known-id ?r - record)
    (ordered ?p - product)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (wish-list-known)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (wish-list-known) (in-wish-list ?p) (not (task-completed)))
    :effect (known-dimensions ?p)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-empty)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (cart-empty) (wish-list-known) (in-wish-list ?p) (known-dimensions ?p) (is-compass ?p) (fits-pocket ?p) (not (task-completed)))
    :effect (and (in-cart ?p) (not (cart-empty)))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (owns-card ?c) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (owns-address ?ad) (not (task-completed)))
    :effect (known-id ?ad)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p) (not (task-completed)))
    :effect (and (ordered ?p) (not (in-cart ?p)) (cart-empty))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product)
    :precondition (and (ordered ?p) (is-compass ?p) (fits-pocket ?p) (in-wish-list ?p) (not (task-completed)))
    :effect (task-completed)
  )
)
