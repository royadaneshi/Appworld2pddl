(define (domain appworld-9bf2c8a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type - object)
  (:constants
    amazon - app
    sofa-item-1 other-item-1 - product)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-viewed)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (product-type-of ?p - product ?pt - product-type)
    (known-type ?p - product)
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
    :effect (cart-viewed))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (cart-viewed) (in-cart ?p) (not (task-completed)))
    :effect (known-type ?p))

  ; API: amazon.move_product_from_cart_to_wish_list
  (:action amazon-move-product-from-cart-to-wish-list
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (cart-viewed) (in-cart ?p) (known-type ?p) (not (task-completed)))
    :effect (and (not (in-cart ?p)) (in-wish-list ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (known-type sofa-item-1) (known-type other-item-1) (in-wish-list sofa-item-1) (not (in-cart sofa-item-1)) (in-cart other-item-1) (not (in-wish-list other-item-1)) (not (task-completed)))
    :effect (task-completed))
)
