(define (domain appworld-cdf61bd-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email order product review rating title - object
  )
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-email ?per - person ?e - email)
    (order-last-calendar-month ?o - order)
    (ordered-in ?p - product ?o - order)
    (review-of ?r - review ?p - product)
    (known-order ?o - order)
    (known-product ?p - product)
    (product-verified ?p - product)
    (known-review ?r - review)
    (review-rating ?r - review ?rt - rating)
    (review-title ?r - review ?ti - title)
    (target-review ?r - review)
    (target-rating ?rt - rating)
    (target-title ?ti - title)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (order-last-calendar-month ?o) (not (task-completed)))
    :effect (known-order ?o)
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-order ?o) (ordered-in ?p ?o) (not (task-completed)))
    :effect (known-product ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-product ?p) (not (task-completed)))
    :effect (product-verified ?p)
  )

  ; API: amazon.show_product_reviews
  (:action amazon-show-product-reviews
    :parameters (?p - product ?e - email ?per - person ?r - review)
    :precondition (and (product-verified ?p) (known-email ?per ?e) (review-of ?r ?p) (not (task-completed)))
    :effect (known-review ?r)
  )

  ; API: amazon.update_product_review
  (:action amazon-update-product-review
    :parameters (?r - review ?t - token ?rt - rating ?ti - title)
    :precondition (and (has-token amazon ?t) (known-review ?r) (not (task-completed)))
    :effect (and (review-rating ?r ?rt) (review-title ?r ?ti))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - review ?rt - rating ?ti - title)
    :precondition (and (target-review ?r) (target-rating ?rt) (target-title ?ti) (review-rating ?r ?rt) (review-title ?r ?ti) (not (task-completed)))
    :effect (task-completed)
  )
)
