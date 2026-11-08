(define (domain appworld-16be9ce-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship birthday query order product price - object)
  (:constants phone amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (birthday-of ?p - person ?b - birthday)
    (known-birthday ?p - person ?b - birthday)
    (order-placed-on ?o - order ?b - birthday)
    (order-matches ?o - order ?q - query)
    (order-contains ?o - order ?pr - product)
    (product-price ?pr - product ?c - price)
    (known-order ?o - order)
    (known-product ?pr - product)
    (found-price ?pr - product ?c - price)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?b - birthday)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (birthday-of ?p ?b) (not (task-completed)))
    :effect (known-birthday ?p ?b))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order ?p - person ?b - birthday)
    :precondition (and (has-token amazon ?t) (known-birthday ?p ?b) (order-placed-on ?o ?b) (order-matches ?o ?q) (not (task-completed)))
    :effect (known-order ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?pr - product)
    :precondition (and (has-token amazon ?t) (known-order ?o) (order-contains ?o ?pr) (not (task-completed)))
    :effect (known-product ?pr))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?pr - product ?c - price)
    :precondition (and (known-product ?pr) (product-price ?pr ?c) (not (task-completed)))
    :effect (found-price ?pr ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - price ?pr - product)
    :precondition (and (found-price ?pr ?c) (not (task-completed)))
    :effect (task-completed))
)
