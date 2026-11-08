(define (domain appworld-9aae7da-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token amount - object)
  (:constants
    amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-cart-total)
    (found-wishlist-total)
    (is-total-cost ?x - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-cart-total)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-wishlist-total)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (found-cart-total)
                       (found-wishlist-total)
                       (is-total-cost ?answer)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
