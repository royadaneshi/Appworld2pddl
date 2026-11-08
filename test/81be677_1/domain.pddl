(define (domain appworld-81be677-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token order delivery-date - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (placed-yesterday ?o - order)
    (known-id ?o - order)
    (found-latest-delivery-date ?o - order ?d - delivery-date)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  (:action amazon-show-orders
    ; API: amazon.show_orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (placed-yesterday ?o) (not (task-completed)))
    :effect (known-id ?o))

  (:action amazon-show-order
    ; API: amazon.show_order
    :parameters (?o - order ?t - token ?d - delivery-date)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (found-latest-delivery-date ?o ?d))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?d - delivery-date ?o - order)
    :precondition (and (found-latest-delivery-date ?o ?d) (not (task-completed)))
    :effect (task-completed)))
