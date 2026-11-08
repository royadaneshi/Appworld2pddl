(define (domain appworld-953b296-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product-type relative-size quantity flag - object
    entity - object
    product question address payment-card order - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (past-purchase ?p - product)
    (product-of-type ?p - product ?pt - product-type)
    (has-size ?p - product ?s - relative-size)
    (known-size ?s - relative-size)
    (question-of ?q - question ?p - product)
    (no-fading-reported ?p - product)
    (reviews-checked ?p - product)
    (qa-checked ?p - product)
    (is-home-address ?a - address)
    (in-cart ?p - product ?qty - quantity)
    (order-placed ?o - order ?p - product ?qty - quantity ?a - address)
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
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_product_purchases
  (:action amazon-show-product-purchases
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (past-purchase ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?s - relative-size)
    :precondition (and (known-id ?p) (past-purchase ?p) (has-size ?p ?s) (not (task-completed)))
    :effect (and (known-size ?s)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?s - relative-size ?p - product)
    :precondition (and (known-size ?s) (product-of-type ?p ?pt) (has-size ?p ?s) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (reviews-checked ?p)))

  ; API: amazon.show_product_questions
  (:action amazon-show-product-questions
    :parameters (?p - product ?q - question)
    :precondition (and (known-id ?p) (question-of ?q ?p) (not (task-completed)))
    :effect (and (known-id ?q)))

  ; API: amazon.show_product_question_answers
  (:action amazon-show-product-question-answers
    :parameters (?q - question ?p - product)
    :precondition (and (known-id ?q) (question-of ?q ?p) (not (task-completed)))
    :effect (and (qa-checked ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (reviews-checked ?p) (qa-checked ?p) (no-fading-reported ?p) (not (in-cart ?p ?qty)) (not (task-completed)))
    :effect (and (in-cart ?p ?qty)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?a) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?qty - quantity ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?p ?qty) (not (order-placed ?o ?p ?qty ?a)) (not (task-completed)))
    :effect (and (order-placed ?o ?p ?qty ?a) (not (in-cart ?p ?qty))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?qty - quantity ?a - address)
    :precondition (and (order-placed ?o ?p ?qty ?a) (not (task-completed)))
    :effect (and (task-completed))))
