(define (domain appworld-81be677-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token order date - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (ordered-yesterday ?o - order)
    (known-id ?o - order)
    (found-arrival-date ?o - order ?d - date)
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
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (ordered-yesterday ?o) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?d - date)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (found-arrival-date ?o ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - date ?o - order)
    :precondition (and (ordered-yesterday ?o) (found-arrival-date ?o ?answer) (not (task-completed)))
    :effect (task-completed))
)
