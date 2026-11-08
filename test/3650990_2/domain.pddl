(define (domain appworld-3650990-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token return-record product answer - object)
  (:constants supervisor amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (returns-listed)
    (return-of ?r - return-record ?p - product)
    (product-type-known ?p - product)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_returns
  (:action amazon-show-returns
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (returns-listed))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?r - return-record)
    :precondition (and (returns-listed) (return-of ?r ?p) (not (product-type-known ?p)) (not (task-completed)))
    :effect (product-type-known ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer ?p1 - product ?p2 - product)
    :precondition (and (product-type-known ?p1) (product-type-known ?p2) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (task-completed))
)
