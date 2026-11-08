(define (domain appworld-3650990-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product answer - object
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (returned-product ?p - product)
    (returns-listed)
    (known-id ?p - product)
    (product-type-known ?p - product)
    (answer-determined)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_returns
  (:action amazon-show-returns
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (returned-product ?p) (not (task-completed)))
    :effect (and (returns-listed) (known-id ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (returns-listed) (known-id ?p) (returned-product ?p) (not (task-completed)))
    :effect (and (product-type-known ?p) (answer-determined))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (returns-listed) (answer-determined) (not (task-completed)))
    :effect (and (task-completed))
  )
)
