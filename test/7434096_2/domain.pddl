(define (domain appworld-7434096-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query order product deliverer quantity - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (order-matches ?o - order ?q - query)
    (known-id ?o - order)
    (order-details-known ?o - order)
    (in-order ?p - product ?o - order)
    (fits ?p - product)
    (deliverers-known)
    (deliverer-available ?d - deliverer)
    (preferred-deliverer ?d - deliverer)
    (return-quantity ?n - quantity)
    (return-initiated ?o - order ?p - product ?d - deliverer ?n - quantity)
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

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-matches ?o ?q) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (order-details-known ?o))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (not (task-completed))
    :effect (deliverers-known))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?n - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (order-details-known ?o) (in-order ?p ?o) (not (fits ?p)) (deliverers-known) (deliverer-available ?d) (preferred-deliverer ?d) (return-quantity ?n) (not (return-initiated ?o ?p ?d ?n)) (not (task-completed)))
    :effect (return-initiated ?o ?p ?d ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?p1 - product ?o2 - order ?p2 - product ?d - deliverer ?n - quantity)
    :precondition (and (return-initiated ?o1 ?p1 ?d ?n) (return-initiated ?o2 ?p2 ?d ?n) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (task-completed))
)
