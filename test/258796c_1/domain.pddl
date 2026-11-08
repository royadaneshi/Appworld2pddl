(define (domain appworld-258796c-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query flag product question hours - object)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (logged-in ?a - app)
    (known-id ?x)
    (search-query-for ?q - query ?p - product)
    (battery-query ?q - query)
    (verified-flag ?v - flag)
    (target-product ?p - product)
    (question-of ?qn - question ?p - product)
    (reviews-checked ?p - product)
    (found-battery-hours ?p - product ?h - hours)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t) (logged-in amazon)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (logged-in amazon) (search-query-for ?q ?p) (not (known-id ?p)) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?q - query ?v - flag)
    :precondition (and (logged-in amazon) (known-id ?p) (battery-query ?q) (verified-flag ?v) (not (task-completed)))
    :effect (and (reviews-checked ?p)))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?q - query ?qn - question)
    :precondition (and (logged-in amazon) (known-id ?p) (battery-query ?q) (not (known-id ?qn)) (not (task-completed)))
    :effect (and (known-id ?qn) (question-of ?qn ?p)))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?qn - question ?v - flag ?p - product ?h - hours)
    :precondition (and (logged-in amazon) (known-id ?qn) (question-of ?qn ?p) (verified-flag ?v) (reviews-checked ?p) (not (task-completed)))
    :effect (and (found-battery-hours ?p ?h)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?h - hours ?p - product)
    :precondition (and (target-product ?p) (reviews-checked ?p) (found-battery-hours ?p ?h) (not (task-completed)))
    :effect (and (task-completed))))
