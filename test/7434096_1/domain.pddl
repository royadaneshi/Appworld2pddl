(define (domain appworld-7434096-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query order product deliverer quantity - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (matches-query ?q - query ?o - order)
    (found-order ?o - order)
    (known-items ?o - order)
    (in-order ?p - product ?o - order)
    (fits ?p - product)
    (purchased-quantity ?p - product ?qty - quantity)
    (deliverers-known)
    (preferred-deliverer ?d - deliverer)
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
    :precondition (and (passwords-known)
                       (username-for amazon ?u)
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t)
                       (matches-query ?q ?o)
                       (not (task-completed)))
    :effect (found-order ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (has-token amazon ?t)
                       (found-order ?o)
                       (not (task-completed)))
    :effect (known-items ?o))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters ()
    :precondition (not (task-completed))
    :effect (deliverers-known))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?qty - quantity ?t - token)
    :precondition (and (has-token amazon ?t)
                       (known-items ?o)
                       (in-order ?p ?o)
                       (not (fits ?p))
                       (purchased-quantity ?p ?qty)
                       (deliverers-known)
                       (preferred-deliverer ?d)
                       (not (return-initiated ?o ?p))
                       (not (task-completed)))
    :effect (return-initiated ?o ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?p1 - product ?o2 - order ?p2 - product)
    :precondition (and
      (return-initiated ?o1 ?p1)
      (return-initiated ?o2 ?p2)
      (not (= ?p1 ?p2))
      (not (task-completed)))
    :effect (task-completed))
)
