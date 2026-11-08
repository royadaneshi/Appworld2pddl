(define (domain appworld-9bf2c8a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person product username password token - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-shown)
    (is-watch ?p - product)
    (in-wish-list ?p - product)
    (in-cart ?p - product)
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

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-shown)))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (wish-list-shown) (in-wish-list ?p) (is-watch ?p) (not (task-completed)))
    :effect (and (not (in-wish-list ?p)) (in-cart ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?w1 ?w2 ?w3 - product)
    :precondition (and (is-watch ?w1) (is-watch ?w2) (is-watch ?w3)
                       (not (= ?w1 ?w2)) (not (= ?w1 ?w3)) (not (= ?w2 ?w3))
                       (in-cart ?w1) (in-cart ?w2) (in-cart ?w3)
                       (not (in-wish-list ?w1)) (not (in-wish-list ?w2)) (not (in-wish-list ?w3))
                       (not (task-completed)))
    :effect (and (task-completed)))
)
