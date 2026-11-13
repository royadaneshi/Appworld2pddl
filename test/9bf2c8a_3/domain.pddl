(define (domain appworld-9bf2c8a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product product-type - object)
  (:constants
    amazon - app
    sofa-item-1 sofa-item-2 sofa-item-3 sofa-item-4 sofa-item-5 sofa-item-6 sofa-item-7 sofa-item-8 sofa-item-9 sofa-item-10 sofa-item-11 sofa-item-12 - product
  )
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
    :precondition (and
      (known-type sofa-item-1)
      (known-type sofa-item-2)
      (known-type sofa-item-3)
      (known-type sofa-item-4)
      (known-type sofa-item-5)
      (known-type sofa-item-6)
      (known-type sofa-item-7)
      (known-type sofa-item-8)
      (known-type sofa-item-9)
      (known-type sofa-item-10)
      (known-type sofa-item-11)
      (known-type sofa-item-12)
      (in-wish-list sofa-item-1)
      (not (in-cart sofa-item-1))
      (in-wish-list sofa-item-2)
      (not (in-cart sofa-item-2))
      (in-wish-list sofa-item-3)
      (not (in-cart sofa-item-3))
      (in-wish-list sofa-item-4)
      (not (in-cart sofa-item-4))
      (in-cart sofa-item-5)
      (not (in-wish-list sofa-item-5))
      (in-cart sofa-item-6)
      (not (in-wish-list sofa-item-6))
      (in-cart sofa-item-7)
      (not (in-wish-list sofa-item-7))
      (in-cart sofa-item-8)
      (not (in-wish-list sofa-item-8))
      (in-cart sofa-item-9)
      (not (in-wish-list sofa-item-9))
      (in-cart sofa-item-10)
      (not (in-wish-list sofa-item-10))
      (in-cart sofa-item-11)
      (not (in-wish-list sofa-item-11))
      (in-cart sofa-item-12)
      (not (in-wish-list sofa-item-12))
      (not (task-completed)))
    :effect (task-completed))
)
