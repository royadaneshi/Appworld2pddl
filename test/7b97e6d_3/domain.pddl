(define (domain appworld-7b97e6d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token quantity count amount entity - object
    product payment-card address - entity)
  (:constants amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (wish-list-known)
    (cart-cleared)
    (in-wish-list ?p - product)
    (in-cart ?p - product)
    (selected-items ?n - count)
    (succ ?n1 - count ?n2 - count)
    (budget ?b - amount)
    (max-count-within-budget ?n - count ?b - amount)
    (order-placed)
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
    :effect (and (wish-list-known)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (and (cart-cleared)))

  ; API: amazon.move_product_from_wish_list_to_cart
  (:action amazon-move-product-from-wish-list-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?n1 - count ?n2 - count)
    :precondition (and (has-token amazon ?t) (wish-list-known) (cart-cleared) (in-wish-list ?p) (not (in-cart ?p)) (selected-items ?n1) (succ ?n1 ?n2) (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p) (not (in-wish-list ?p)) (selected-items ?n2) (not (selected-items ?n1))))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?n - count ?b - amount)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (cart-cleared) (selected-items ?n) (budget ?b) (max-count-within-budget ?n ?b) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed)))
)
