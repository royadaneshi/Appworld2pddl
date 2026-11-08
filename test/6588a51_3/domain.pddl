(define (domain appworld-6588a51-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product product-type question - object
  )
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-order ?o - order)
    (known-product ?p - product)
    (order-contains ?o - order ?p - product)
    (product-has-type ?p - product ?pt - product-type)
    (type-known ?p - product ?pt - product-type)
    (last-ordered-of-type ?p - product ?pt - product-type)
    (question-posted ?p - product ?q - question)
    (task-completed)
  )
  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )
  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )
  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-order ?o)
  )
  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-order ?o) (order-contains ?o ?p) (not (task-completed)))
    :effect (known-product ?p)
  )
  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?pt - product-type)
    :precondition (and (known-product ?p) (product-has-type ?p ?pt) (not (task-completed)))
    :effect (type-known ?p ?pt)
  )
  ; API: amazon.write_product_question
  (:action amazon-write-product-question
    :parameters (?p - product ?q - question ?t - token ?pt - product-type)
    :precondition (and (has-token amazon ?t) (known-product ?p) (type-known ?p ?pt) (last-ordered-of-type ?p ?pt) (not (task-completed)))
    :effect (question-posted ?p ?q)
  )
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - question)
    :precondition (and (question-posted ?p ?q) (not (task-completed)))
    :effect (task-completed)
  )
)
