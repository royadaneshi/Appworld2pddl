(define (domain appworld-eb5ad85-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token order amount - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (in-period ?o - order)
    (found-total ?o - order)
    (running-spend ?amt - amount)
    (adds-to-spend ?o - order ?from - amount ?to - amount)
    (final-spend ?amt - amount)
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
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (orders-listed))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?from - amount ?to - amount)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (orders-listed) (in-period ?o) (not (found-total ?o)) (running-spend ?from) (adds-to-spend ?o ?from ?to))
    :effect (and (found-total ?o) (not (running-spend ?from)) (running-spend ?to)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (not (task-completed)) (final-spend ?ans) (running-spend ?ans))
    :effect (task-completed)))
