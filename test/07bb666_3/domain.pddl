(define (domain appworld-07bb666-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token product - object)
  (:constants
    amazon supervisor - app
    product-1 product-2 product-4 product-3 product-5 product-6 - product)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-known)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (rating-over-4-3 ?p - product)
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

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-known))

  ; API: amazon.move_product_from_cart_to_wish_list
  (:action amazon-move-product-from-cart-to-wish-list
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (cart-known) (in-cart ?p) (rating-over-4-3 ?p) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (in-wish-list ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (in-wish-list product-1)
      (not (in-cart product-1))
      (in-wish-list product-2)
      (not (in-cart product-2))
      (in-wish-list product-3)
      (not (in-cart product-3))
      (in-cart product-4)
      (in-cart product-5)
      (in-cart product-6)
      (not (task-completed)))
    :effect (task-completed))
)
