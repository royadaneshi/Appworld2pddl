(define (domain appworld-d9987f6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type rating quantity record - object
    product address payment-card - record)
  (:constants amazon supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - record)
    (wanted-type ?pt - product-type)
    (wanted-rating ?r - rating)
    (product-type-of ?p - product ?pt - product-type)
    (rating-above ?p - product ?r - rating)
    (candidate ?p - product)
    (is-home ?a - address)
    (single-unit ?q - quantity)
    (cart-may-have-items)
    (cart-empty)
    (in-cart ?p - product ?q - quantity)
    (ordered ?p - product ?q - quantity ?a - address)
    (order-placed)
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

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?r - rating ?p - product)
    :precondition (and (wanted-type ?pt) (wanted-rating ?r) (product-type-of ?p ?pt) (rating-above ?p ?r) (not (task-completed)))
    :effect (and (known-id ?p) (candidate ?p)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (cart-may-have-items) (not (task-completed)))
    :effect (and (not (cart-may-have-items)) (cart-empty)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?p) (candidate ?p) (single-unit ?q) (cart-empty) (not (task-completed)))
    :effect (and (in-cart ?p ?q) (not (cart-empty))))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home ?a) (in-cart ?p ?q) (candidate ?p) (single-unit ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?a) (not (in-cart ?p ?q)) (cart-empty) (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed))
)
