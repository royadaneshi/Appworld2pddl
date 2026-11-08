(define (domain appworld-7d26579-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query answer - object
    entity - object
    order product question - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (is-supervisor ?p - person)
    (supervisor-email ?e - email)
    (orders-query ?q - query)
    (is-last-tshirt-order ?o - order)
    (order-has-product ?o - order ?p - product)
    (product-is-tshirt ?p - product)
    (question-by-user ?q - question ?p - product)
    (known-id ?x - entity)
    (verified-tshirt ?p - product)
    (found-answer ?ans - answer))

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
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (orders-query ?q) (is-last-tshirt-order ?o) (not (task-completed)))
    :effect (and (known-id ?o)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (known-id ?o) (has-token amazon ?t) (order-has-product ?o ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (product-is-tshirt ?p) (not (task-completed)))
    :effect (and (verified-tshirt ?p)))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?e - email ?q - question)
    :precondition (and (known-id ?p) (verified-tshirt ?p) (supervisor-email ?e) (question-by-user ?q ?p) (not (task-completed)))
    :effect (and (known-id ?q)))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?q - question ?ans - answer)
    :precondition (and (known-id ?q) (not (task-completed)))
    :effect (and (found-answer ?ans)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (found-answer ?ans) (not (task-completed)))
    :effect (and (task-completed)))
)
