(define (domain appworld-9aae7da-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token amount - object)
  (:constants
    amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (found-cart-cost)
    (found-wishlist-cost)
    (answer-total ?x - amount)
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
                       (username-for amazon ?u)
                       (password-for amazon ?pw)
                       (not (has-token amazon ?t))
                       (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-cart-cost)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-wishlist-cost)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (found-cart-cost)
                       (found-wishlist-cost)
                       (answer-total ?ans)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
