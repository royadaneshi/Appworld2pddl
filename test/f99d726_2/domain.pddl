(define (domain appworld-f99d726-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product order deliverer payment-card address quantity flag - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (is-last-sweater ?p - product)
    (ordered-in ?p - product ?o - order)
    (is-replacement ?p - product)
    (return-initiated ?o - order ?p - product)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?p - product ?q - quantity)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product ?o - order)
    :precondition (and (has-token amazon ?t) (is-last-sweater ?p) (ordered-in ?p ?o) (not (task-completed)))
    :effect (and (known-id ?p) (known-id ?o)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?rep - product)
    :precondition (and (known-id ?p) (is-last-sweater ?p) (is-replacement ?rep) (not (task-completed)))
    :effect (known-id ?rep))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (known-id ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (known-id ?p) (known-id ?d) (is-last-sweater ?p) (ordered-in ?p ?o) (not (return-initiated ?o ?p)) (not (task-completed)))
    :effect (return-initiated ?o ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (is-replacement ?p) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?q) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?o - order ?rep - product ?q - quantity)
    :precondition (and (is-last-sweater ?p) (ordered-in ?p ?o) (return-initiated ?o ?p) (is-replacement ?rep) (order-placed ?rep ?q) (not (task-completed)))
    :effect (task-completed))
)
