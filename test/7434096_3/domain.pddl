(define (domain appworld-7434096-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query order product deliverer quantity - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (search-query ?q - query)
    (orders-listed)
    (order-inspected ?o - order)
    (item-in-order ?p - product ?o - order)
    (fits ?p - product)
    (item-quantity ?p - product ?q - quantity)
    (deliverers-known)
    (deliverer-available ?d - deliverer)
    (preferred-deliverer ?d - deliverer)
    (return-initiated ?o - order ?p - product ?d - deliverer)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (search-query ?q))
    :effect (orders-listed))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (orders-listed))
    :effect (order-inspected ?o))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (deliverers-known))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (order-inspected ?o) (item-in-order ?p ?o) (not (fits ?p)) (item-quantity ?p ?q) (deliverers-known) (deliverer-available ?d) (not (return-initiated ?o ?p ?d)))
    :effect (return-initiated ?o ?p ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?p1 - product ?o2 - order ?p2 - product ?d - deliverer)
    :precondition (and (not (task-completed)) (not (= ?p1 ?p2)) (preferred-deliverer ?d) (return-initiated ?o1 ?p1 ?d) (return-initiated ?o2 ?p2 ?d))
    :effect (task-completed))
)
