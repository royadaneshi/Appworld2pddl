(define (domain appworld-9bf2c8a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person product username password token quantity - object
  )
  (:constants
    amazon - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-cart ?p - product)
    (in-wish-list ?p - product)
    (cart-quantity ?p - product ?q - quantity)
    (is-food-processor ?p - product)
    (cart-contents-known)
    (known-product-type ?p - product)
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
    :precondition (and
      (passwords-known)
      (username-for amazon ?u)
      (password-for amazon ?pw)
      (not (has-token amazon ?t))
      (not (task-completed))
    )
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and
      (has-token amazon ?t)
      (not (task-completed))
    )
    :effect (cart-contents-known)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and
      (cart-contents-known)
      (in-cart ?p)
      (not (task-completed))
    )
    :effect (known-product-type ?p)
  )

  ; API: amazon.move_product_from_cart_to_wish_list
  (:action amazon-move-product-from-cart-to-wish-list
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and
      (has-token amazon ?t)
      (cart-contents-known)
      (in-cart ?p)
      (known-product-type ?p)
      (is-food-processor ?p)
      (cart-quantity ?p ?q)
      (not (task-completed))
    )
    :effect (and
      (not (in-cart ?p))
      (in-wish-list ?p)
    )
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?fp1 - product ?fp2 - product)
    :precondition (and
      (not (= ?fp1 ?fp2))
      (is-food-processor ?fp1)
      (is-food-processor ?fp2)
      (in-wish-list ?fp1)
      (not (in-cart ?fp1))
      (in-wish-list ?fp2)
      (not (in-cart ?fp2))
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
