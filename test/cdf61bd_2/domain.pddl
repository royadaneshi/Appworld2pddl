(define (domain appworld-cdf61bd-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email rating title entity - object
    order product review - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (ordered-last-calendar-month ?o - order)
    (order-contains ?o - order ?p - product)
    (review-of ?r - review ?p - product)
    (known-id ?x - entity)
    (product-details-known ?p - product)
    (review-updated ?r - review ?rt - rating ?ti - title)
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
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (ordered-last-calendar-month ?o) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (known-id ?o) (has-token amazon ?t) (order-contains ?o ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (product-details-known ?p))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?e - email ?r - review)
    :precondition (and (known-id ?p) (product-details-known ?p) (supervisor-email ?e) (review-of ?r ?p) (not (task-completed)))
    :effect (known-id ?r))

  ; API: amazon.update_product_review
  (:action amazon-update-product-review
    :parameters (?r - review ?t - token ?rt - rating ?ti - title)
    :precondition (and (known-id ?r) (has-token amazon ?t) (not (task-completed)))
    :effect (review-updated ?r ?rt ?ti))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - review ?rt - rating ?ti - title)
    :precondition (and (review-updated ?r ?rt ?ti) (not (task-completed)))
    :effect (task-completed)))
