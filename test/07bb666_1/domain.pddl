(define (domain appworld-07bb666-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person product username password token - object)
  (:constants
    amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (rating-under-threshold ?p - product)
    (cart-listed)
    (rating-known ?p - product))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-listed))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (cart-listed) (in-cart ?p) (not (task-completed)))
    :effect (rating-known ?p))

  ; API: amazon.move_product_from_cart_to_wish_list
  (:action amazon-move-product-from-cart-to-wish-list
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (cart-listed) (in-cart ?p) (rating-known ?p) (rating-under-threshold ?p) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (in-wish-list ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (cart-listed) (not (task-completed)))
    :effect (task-completed)))
