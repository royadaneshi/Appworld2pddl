(define (domain appworld-81be677-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token order date - object)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (placed-today ?o - order)
    (arrival-date-of ?o - order ?d - date)
    (known-id ?o - order)
    (found-arrival-date ?d - date)
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
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (placed-today ?o) (not (task-completed)))
    :effect (and (known-id ?o)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?d - date)
    :precondition (and (has-token amazon ?t) (known-id ?o) (arrival-date-of ?o ?d) (not (task-completed)))
    :effect (and (found-arrival-date ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - date)
    :precondition (and (found-arrival-date ?d) (not (task-completed)))
    :effect (and (task-completed)))
)
