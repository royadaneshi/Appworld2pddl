(define (domain appworld-3650990-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token return-record product answer - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (returns-listed)
    (known-id ?r - return-record)
    (found-return-date ?r - return-record)
    (return-of-product ?r - return-record ?p - product)
    (known-product-id ?p - product)
    (found-product-type ?p - product)
    (answer-known ?ans - answer)
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

  ; API: amazon.show_returns
  (:action amazon-show-returns
    :parameters (?t - token ?r - return-record)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (returns-listed) (known-id ?r) (found-return-date ?r)))

  ; API: amazon.show_return
  (:action amazon-show-return
    :parameters (?r - return-record ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?r) (not (task-completed)))
    :effect (and (return-of-product ?r ?p) (known-product-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?r - return-record ?ans - answer)
    :precondition (and (known-product-id ?p) (return-of-product ?r ?p) (found-return-date ?r) (not (task-completed)))
    :effect (and (found-product-type ?p) (answer-known ?ans)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (answer-known ?ans) (not (task-completed)))
    :effect (task-completed))
)
