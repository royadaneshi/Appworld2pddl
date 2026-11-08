(define (domain appworld-5238afc-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product payment-card address count - object)
  (:constants
    amazon - app
    zero - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (in-cart ?p - product)
    (is-stapler ?p - product)
    (known-type ?p - product)
    (payment-cards-known)
    (addresses-known)
    (succ ?n - count ?m - count)
    (non-staplers-in-cart ?n - count)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (cart-known)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (cart-known) (in-cart ?p) (not (task-completed)))
    :effect (and (known-type ?p)))

  ; API: amazon.delete_product_from_cart
  (:action amazon-delete-product-from-cart
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (known-type ?p) (not (is-stapler ?p)) (non-staplers-in-cart ?n) (succ ?m ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (not (non-staplers-in-cart ?n)) (non-staplers-in-cart ?m)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (payment-cards-known)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (addresses-known)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (payment-cards-known) (addresses-known) (non-staplers-in-cart zero) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))))
