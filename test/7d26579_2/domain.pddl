(define (domain appworld-7d26579-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email order product question answer - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (order-matches ?o - order ?q - query)
    (known-order ?o - order)
    (in-order ?o - order ?p - product)
    (known-product ?p - product)
    (question-on ?qn - question ?p - product)
    (asked-by ?qn - question ?e - email)
    (known-question ?qn - question)
    (answers-question ?ans - answer ?qn - question)
    (found-answer ?ans - answer))

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
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-matches ?o ?q) (not (task-completed)))
    :effect (known-order ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-order ?o) (in-order ?o ?p) (not (task-completed)))
    :effect (known-product ?p))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?e - email ?qn - question)
    :precondition (and (known-product ?p) (question-on ?qn ?p) (asked-by ?qn ?e) (not (task-completed)))
    :effect (known-question ?qn))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?qn - question ?ans - answer)
    :precondition (and (known-question ?qn) (answers-question ?ans ?qn) (not (task-completed)))
    :effect (found-answer ?ans))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - answer)
    :precondition (and (found-answer ?ans) (not (task-completed)))
    :effect (task-completed))
)
