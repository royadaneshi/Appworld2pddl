(define (domain appworld-258796c-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person entity query verified-flag hours - object
    product question - entity)
  (:constants amazon supervisor - app)
  (:predicates
    (known-id ?x - entity)
    (search-query-for ?q - query ?p - product)
    (battery-query ?q - query)
    (verified-only ?v - verified-flag)
    (question-about ?qn - question ?p - product)
    (verified-reviews-checked ?p - product)
    (verified-answers-checked ?p - product)
    (task-completed))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (not (task-completed)) (search-query-for ?q ?p))
    :effect (known-id ?p))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?q - query ?v - verified-flag)
    :precondition (and (not (task-completed)) (known-id ?p) (battery-query ?q) (verified-only ?v))
    :effect (verified-reviews-checked ?p))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?q - query ?qn - question)
    :precondition (and (not (task-completed)) (known-id ?p) (battery-query ?q) (question-about ?qn ?p))
    :effect (known-id ?qn))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?qn - question ?v - verified-flag ?p - product)
    :precondition (and (not (task-completed)) (known-id ?qn) (question-about ?qn ?p) (verified-only ?v))
    :effect (verified-answers-checked ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?h - hours ?p - product)
    :precondition (and (not (task-completed)) (verified-reviews-checked ?p) (verified-answers-checked ?p))
    :effect (task-completed)))
