(define (domain appworld-7d26579-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email answer entity - object
    order product question - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (target-order ?o - order)
    (order-contains ?o - order ?pr - product)
    (is-tshirt ?pr - product)
    (type-checked ?pr - product)
    (supervisor-email ?p - person ?e - email)
    (asked ?p - person ?q - question ?pr - product)
    (found-answer ?ans - answer)
    (answer-known)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (target-order ?o) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?pr - product)
    :precondition (and (known-id ?o) (has-token amazon ?t) (order-contains ?o ?pr) (not (task-completed)))
    :effect (known-id ?pr))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?pr - product)
    :precondition (and (known-id ?pr) (not (task-completed)))
    :effect (type-checked ?pr))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?pr - product ?e - email ?p - person ?q - question)
    :precondition (and (known-id ?pr) (type-checked ?pr) (is-tshirt ?pr)
                       (supervisor-email ?p ?e) (asked ?p ?q ?pr) (not (task-completed)))
    :effect (known-id ?q))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?q - question ?ans - answer)
    :precondition (and (known-id ?q) (not (answer-known)) (not (task-completed)))
    :effect (and (found-answer ?ans) (answer-known)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (answer-known) (found-answer ?ans) (not (task-completed)))
    :effect (task-completed))
)
