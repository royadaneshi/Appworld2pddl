(define (domain appworld-07bb666-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product quantity - object
  )
  (:constants
    amazon supervisor - app
    wl-product-1 wl-product-2 wl-product-3 wl-product-4 - product
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-known)
    (in-wish-list ?p - product)
    (wish-list-quantity ?p - product ?q - quantity)
    (rating-known ?p - product)
    (rating-over-threshold ?p - product)
    (in-cart ?p - product)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-known))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (wish-list-known) (in-wish-list ?p) (not (task-completed)))
    :effect (and (rating-known ?p))
  )

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (wish-list-known) (in-wish-list ?p) (wish-list-quantity ?p ?q) (rating-known ?p) (rating-over-threshold ?p) (not (task-completed)))
    :effect (and (in-cart ?p) (not (in-wish-list ?p)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-cart wl-product-1) (not (in-wish-list wl-product-1))
      (in-cart wl-product-2) (not (in-wish-list wl-product-2))
      (in-cart wl-product-3) (not (in-wish-list wl-product-3))
      (in-wish-list wl-product-4) (not (in-cart wl-product-4))
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
