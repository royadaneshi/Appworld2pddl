(define (domain appworld-5238afc-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token count product record - object
    address payment-card - record
  )
  (:constants amazon - app n0 - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (in-cart ?p - product)
    (is-beach-ball ?p - product)
    (others-in-cart ?n - count)
    (succ ?m - count ?n - count)
    (known-id ?r - record)
    (order-placed)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-known))
  )

  ; API: amazon.delete_product_from_cart
  (:action amazon-delete-product-from-cart
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (not (is-beach-ball ?p)) (others-in-cart ?n) (succ ?m ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (not (others-in-cart ?n)) (others-in-cart ?m))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
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
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (cart-known) (others-in-cart n0) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
