(define (domain appworld-9aae7da-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token amount - object)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-cart-total ?c - amount)
    (found-wishlist-total ?w - amount)
    (sum-of ?c - amount ?w - amount ?total - amount)
    (answered ?total - amount)
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
    :parameters (?t - token ?c - amount)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-cart-total ?c)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token ?w - amount)
    :precondition (and (has-token amazon ?t)
                       (not (task-completed)))
    :effect (and (found-wishlist-total ?w)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?a - amount ?c - amount ?w - amount)
    :precondition (and (found-cart-total ?c)
                       (found-wishlist-total ?w)
                       (sum-of ?c ?w ?a)
                       (not (task-completed)))
    :effect (and (answered ?a) (task-completed)))
)
