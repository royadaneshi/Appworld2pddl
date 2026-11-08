(define (domain appworld-1c4bd27-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product deliverer quantity - object)
  (:constants
    amazon - app
    order-1 order-2 order-3 - order
    product-1a product-1b product-2a product-3a product-3b - product
    fedex - deliverer)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (order-contains ?o - order ?p - product)
    (item-quantity ?o - order ?p - product ?q - quantity)
    (known-order ?o - order)
    (order-details-known ?o - order)
    (known-deliverer ?d - deliverer)
    (return-initiated ?o - order ?p - product ?d - deliverer))

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

  ; API: amazon.show_orders  (lists past orders; the three most recent ones are order-1, order-2, order-3)
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-order order-1) (known-order order-2) (known-order order-3)))

  ; API: amazon.show_order  (reveals the order items: product ids and quantities)
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (has-token amazon ?t) (known-order ?o) (not (task-completed)))
    :effect (order-details-known ?o))

  ; API: amazon.show_return_deliverers  (reveals the deliverer id of FedEx)
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (not (task-completed))
    :effect (known-deliverer fedex))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (order-details-known ?o) (order-contains ?o ?p) (item-quantity ?o ?p ?q) (known-deliverer ?d) (not (return-initiated ?o ?p ?d)) (not (task-completed)))
    :effect (return-initiated ?o ?p ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (return-initiated order-1 product-1a fedex) (return-initiated order-1 product-1b fedex) (return-initiated order-2 product-2a fedex) (return-initiated order-3 product-3a fedex) (return-initiated order-3 product-3b fedex) (not (task-completed)))
    :effect (task-completed))
)
