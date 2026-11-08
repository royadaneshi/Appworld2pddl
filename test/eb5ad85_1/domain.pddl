(define (domain appworld-eb5ad85-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order amount year - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?o - order)
    (current-year ?y - year)
    (order-in-year ?o - order ?y - year)
    (found-order-total ?o - order ?amt - amount)
    (answered ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order ?y - year)
    :precondition (and (has-token amazon ?t) (current-year ?y) (order-in-year ?o ?y) (not (task-completed)))
    :effect (and (known-id ?o)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (and (found-order-total ?o ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount ?o - order ?y - year)
    :precondition (and (current-year ?y) (order-in-year ?o ?y) (found-order-total ?o ?amt) (not (task-completed)))
    :effect (and (task-completed) (answered ?amt)))
)
