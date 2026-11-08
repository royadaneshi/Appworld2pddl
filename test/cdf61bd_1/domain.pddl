(define (domain appworld-cdf61bd-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email rating title entity - object
    order product review - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (supervisor-email ?p - person ?e - email)
    (ordered-last-month ?o - order)
    (order-contains ?o - order ?p - product)
    (grey-tshirt ?p - product)
    (reviewed ?r - review ?p - product ?e - email)
    (known-id ?x - entity)
    (product-details-known ?p - product)
    (review-rating ?r - review ?rt - rating)
    (review-title ?r - review ?ti - title))

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
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (ordered-last-month ?o) (not (task-completed)))
    :effect (and (known-id ?o)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (known-id ?o) (has-token amazon ?t) (order-contains ?o ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (product-details-known ?p)))

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?e - email ?r - review)
    :precondition (and (known-id ?p) (product-details-known ?p) (grey-tshirt ?p) (reviewed ?r ?p ?e) (not (task-completed)))
    :effect (and (known-id ?r)))

  ; API: amazon.update_product_review
  (:action amazon-update-product-review
    :parameters (?r - review ?t - token ?rt - rating ?ti - title)
    :precondition (and (known-id ?r) (has-token amazon ?t) (not (task-completed)))
    :effect (and (review-rating ?r ?rt) (review-title ?r ?ti)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - review ?rt - rating ?ti - title)
    :precondition (and (review-rating ?r ?rt) (review-title ?r ?ti) (not (task-completed)))
    :effect (and (task-completed)))
)
