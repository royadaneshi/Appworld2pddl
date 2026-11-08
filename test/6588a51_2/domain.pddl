(define (domain appworld-6588a51-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order product product-type question - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (wanted-type ?pt - product-type)
    (latest-order-of-type ?o - order ?pt - product-type)
    (in-order ?p - product ?o - order)
    (has-product-type ?p - product ?pt - product-type)
    (known-order-id ?o - order)
    (known-product-id ?p - product)
    (type-verified ?p - product)
    (question-posted ?p - product ?q - question))

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
    :parameters (?t - token ?o - order ?pt - product-type)
    :precondition (and (has-token amazon ?t) (wanted-type ?pt) (latest-order-of-type ?o ?pt) (not (task-completed)))
    :effect (known-order-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-order-id ?o) (in-order ?p ?o) (not (task-completed)))
    :effect (known-product-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-product-id ?p) (not (task-completed)))
    :effect (type-verified ?p))

  ; API: amazon.write_product_question
  (:action amazon-write-product-question
    :parameters (?p - product ?q - question ?t - token)
    :precondition (and (has-token amazon ?t) (known-product-id ?p) (type-verified ?p) (not (task-completed)))
    :effect (question-posted ?p ?q))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - question)
    :precondition (and (question-posted ?p ?q) (not (task-completed)))
    :effect (task-completed))
)
