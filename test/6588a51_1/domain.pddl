(define (domain appworld-6588a51-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product product-type question-text - object
  )
  (:constants
    supervisor amazon - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?o - order)
    (in-order ?o - order ?p - product)
    (known-product ?p - product)
    (has-type ?p - product ?pt - product-type)
    (known-type ?p - product ?pt - product-type)
    (question-posted ?p - product ?q - question-text)
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

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?o))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (in-order ?o ?p) (not (task-completed)))
    :effect (and (known-product ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?pt - product-type)
    :precondition (and (known-product ?p) (has-type ?p ?pt) (not (task-completed)))
    :effect (and (known-type ?p ?pt))
  )

  ; API: amazon.write_product_question
  (:action amazon-write-product-question
    :parameters (?p - product ?q - question-text ?t - token ?pt - product-type)
    :precondition (and (has-token amazon ?t) (known-type ?p ?pt) (not (question-posted ?p ?q)) (not (task-completed)))
    :effect (and (question-posted ?p ?q))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - question-text)
    :precondition (and (question-posted ?p ?q) (not (task-completed)))
    :effect (and (task-completed))
  )
)
