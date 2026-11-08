(define (domain appworld-1c4bd27-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product deliverer quantity - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (order-details-known ?o - order)
    (in-order ?o - order ?p - product)
    (item-quantity ?p - product ?q - quantity)
    (deliverers-listed)
    (return-initiated ?p - product ?d - deliverer)
    (task-completed)
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
    :precondition (and
      (passwords-known)
      (username-for amazon ?u)
      (password-for amazon ?pw)
      (not (has-token amazon ?t))
      (not (task-completed))
    )
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and
      (has-token amazon ?t)
      (not (task-completed))
    )
    :effect (orders-listed)
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and
      (orders-listed)
      (has-token amazon ?t)
      (not (task-completed))
    )
    :effect (order-details-known ?o)
  )

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (not (task-completed))
    :effect (deliverers-listed)
  )

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and
      (has-token amazon ?t)
      (order-details-known ?o)
      (in-order ?o ?p)
      (item-quantity ?p ?q)
      (deliverers-listed)
      (not (return-initiated ?p ?d))
      (not (task-completed))
    )
    :effect (return-initiated ?p ?d)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 ?p2 ?p3 ?p4 - product ?d - deliverer)
    :precondition (and
      (return-initiated ?p1 ?d)
      (return-initiated ?p2 ?d)
      (return-initiated ?p3 ?d)
      (return-initiated ?p4 ?d)
      (not (= ?p1 ?p2))
      (not (= ?p1 ?p3))
      (not (= ?p1 ?p4))
      (not (= ?p2 ?p3))
      (not (= ?p2 ?p4))
      (not (= ?p3 ?p4))
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
