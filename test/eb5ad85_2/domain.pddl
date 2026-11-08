(define (domain appworld-eb5ad85-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order amount - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (placed-last-month ?o - order)
    (found-total ?o - order)
    (answer-for ?amt - amount ?o - order)
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
    :precondition (and (has-token amazon ?t) (orders-listed) (placed-last-month ?o) (not (task-completed)))
    :effect (found-total ?o))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount ?o - order)
    :precondition (and (answer-for ?ans ?o) (placed-last-month ?o) (found-total ?o) (not (task-completed)))
    :effect (task-completed))
)
