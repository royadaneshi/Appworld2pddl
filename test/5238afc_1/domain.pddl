(define (domain appworld-5238afc-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person product order address payment-card username password token count - object)
  (:constants amazon - app zero - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (in-cart ?p - product)
    (is-weightlifting-bench ?p - product)
    (unwanted-in-cart ?n - count)
    (count-pred ?m - count ?n - count)
    (addresses-known)
    (payment-cards-known)
    (order-placed ?o - order)
    (task-completed))
  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))
  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))
  (:action amazon-show-cart
    ; API: amazon.show_cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-known))
  (:action amazon-delete-product-from-cart
    ; API: amazon.delete_product_from_cart
    :parameters (?p - product ?t - token ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (not (is-weightlifting-bench ?p)) (unwanted-in-cart ?n) (count-pred ?m ?n) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (not (unwanted-in-cart ?n)) (unwanted-in-cart ?m)))
  (:action amazon-show-addresses
    ; API: amazon.show_addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (addresses-known))
  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-cards-known))
  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (cart-known) (payment-cards-known) (addresses-known) (unwanted-in-cart zero) (not (order-placed ?o)) (not (task-completed)))
    :effect (order-placed ?o))
  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?o - order)
    :precondition (and (order-placed ?o) (not (task-completed)))
    :effect (task-completed)))
