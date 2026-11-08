(define (domain appworld-f99d726-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token quantity flag entity - object
    product order deliverer payment-card address - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (last-tshirt-purchase ?p - product ?o - order)
    (next-size-variant ?p - product ?v - product)
    (unit-quantity ?q - quantity)
    (flag-true ?f - flag)
    (found-last-tshirt ?p - product ?o - order)
    (replacement-found ?v - product)
    (return-initiated ?p - product ?o - order)
    (in-cart ?p - product)
    (ordered ?p - product)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product ?o - order)
    :precondition (and (has-token amazon ?t) (last-tshirt-purchase ?p ?o) (not (task-completed)))
    :effect (and (found-last-tshirt ?p ?o) (known-id ?p) (known-id ?o)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?v - product)
    :precondition (and (known-id ?p) (next-size-variant ?p ?v) (not (task-completed)))
    :effect (and (replacement-found ?v) (known-id ?v)))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-id ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (found-last-tshirt ?p ?o) (known-id ?d) (unit-quantity ?q) (not (return-initiated ?p ?o)) (not (task-completed)))
    :effect (return-initiated ?p ?o))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?v - product ?t - token ?q - quantity ?c - flag)
    :precondition (and (has-token amazon ?t) (replacement-found ?v) (unit-quantity ?q) (flag-true ?c) (not (in-cart ?v)) (not (task-completed)))
    :effect (in-cart ?v))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?v - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?v) (replacement-found ?v) (not (task-completed)))
    :effect (and (ordered ?v) (not (in-cart ?v))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?o - order ?v - product)
    :precondition (and (last-tshirt-purchase ?p ?o) (next-size-variant ?p ?v) (return-initiated ?p ?o) (ordered ?v) (not (task-completed)))
    :effect (task-completed))
)
