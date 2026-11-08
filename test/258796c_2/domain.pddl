(define (domain appworld-258796c-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query boolean hours entity - object
    product question - entity)
  (:constants amazon - app)
  (:predicates
    (supervisor-user ?x - person)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (logged-in ?a - app)
    (search-query-for ?q - query ?p - product)
    (battery-query ?q - query)
    (is-true ?v - boolean)
    (question-about ?qu - question ?p - product)
    (known-id ?x - entity)
    (verified-reviews-checked ?p - product)
    (verified-answers-checked ?qu - question)
    (found-battery-hours ?p - product ?h - hours)
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
    :effect (and (has-token amazon ?t) (logged-in amazon)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (logged-in amazon) (search-query-for ?q ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?q - query ?v - boolean)
    :precondition (and (known-id ?p) (battery-query ?q) (is-true ?v) (not (task-completed)))
    :effect (verified-reviews-checked ?p))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?q - query ?qu - question)
    :precondition (and (known-id ?p) (battery-query ?q) (question-about ?qu ?p) (not (task-completed)))
    :effect (known-id ?qu))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?qu - question ?v - boolean ?p - product ?h - hours)
    :precondition (and (known-id ?qu) (question-about ?qu ?p) (is-true ?v) (not (task-completed)))
    :effect (and (verified-answers-checked ?qu) (found-battery-hours ?p ?h)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?h - hours ?p - product ?qu - question)
    :precondition (and (verified-reviews-checked ?p) (verified-answers-checked ?qu) (found-battery-hours ?p ?h) (not (task-completed)))
    :effect (task-completed))
)
