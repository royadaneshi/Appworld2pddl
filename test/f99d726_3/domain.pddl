(define (domain appworld-f99d726-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type order product deliverer return-quantity cart-quantity flag payment-card address - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (found-last-purchase ?pt - product-type ?o - order ?p - product)
    (order-quantity-known ?o - order ?p - product ?q - return-quantity)
    (replacement-known ?p - product ?rep - product)
    (deliverer-known ?d - deliverer)
    (return-initiated ?o - order ?p - product)
    (in-cart ?p - product ?q - cart-quantity)
    (payment-card-known ?c - payment-card)
    (address-known ?a - address)
    (ordered ?p - product ?q - cart-quantity))

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
    :parameters (?t - token ?pt - product-type ?o - order ?p - product)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (found-last-purchase ?pt ?o ?p))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product ?q - return-quantity ?pt - product-type)
    :precondition (and (has-token amazon ?t) (found-last-purchase ?pt ?o ?p) (not (task-completed)))
    :effect (order-quantity-known ?o ?p ?q))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?rep - product ?pt - product-type ?o - order)
    :precondition (and (found-last-purchase ?pt ?o ?p) (not (= ?p ?rep)) (not (task-completed)))
    :effect (replacement-known ?p ?rep))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (deliverer-known ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - return-quantity ?t - token)
    :precondition (and (has-token amazon ?t) (order-quantity-known ?o ?p ?q) (deliverer-known ?d) (not (return-initiated ?o ?p)) (not (task-completed)))
    :effect (return-initiated ?o ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?rep - product ?t - token ?q - cart-quantity ?clear - flag ?p - product)
    :precondition (and (has-token amazon ?t) (replacement-known ?p ?rep) (not (task-completed)))
    :effect (in-cart ?rep ?q))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (payment-card-known ?c))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (address-known ?a))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?rep - product ?q - cart-quantity)
    :precondition (and (has-token amazon ?t) (payment-card-known ?c) (address-known ?a) (in-cart ?rep ?q) (not (task-completed)))
    :effect (and (ordered ?rep ?q) (not (in-cart ?rep ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?rep - product ?q - cart-quantity)
    :precondition (and (return-initiated ?o ?p) (ordered ?rep ?q) (not (task-completed)))
    :effect (task-completed))
)
