(define (domain appworld-1c4bd27-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product deliverer quantity - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (recent-order ?o - order)
    (known-items ?o - order)
    (item-of ?o - order ?p - product ?q - quantity)
    (deliverers-listed)
    (fedex-deliverer ?d - deliverer)
    (return-initiated ?o - order ?p - product)
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
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (orders-listed))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (has-token amazon ?t) (orders-listed) (recent-order ?o) (not (task-completed)))
    :effect (known-items ?o))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (not (task-completed))
    :effect (deliverers-listed))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (known-items ?o) (item-of ?o ?p ?q) (deliverers-listed) (fedex-deliverer ?d) (not (return-initiated ?o ?p)) (not (task-completed)))
    :effect (return-initiated ?o ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 ?o2 - order ?p1 ?p2 ?p3 ?p4 - product)
    :precondition (and (recent-order ?o1) (recent-order ?o2) (not (= ?o1 ?o2)) (not (= ?p1 ?p2)) (not (= ?p3 ?p4)) (return-initiated ?o1 ?p1) (return-initiated ?o1 ?p2) (return-initiated ?o2 ?p3) (return-initiated ?o2 ?p4) (not (task-completed)))
    :effect (task-completed))
)
