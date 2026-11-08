(define (domain appworld-16be9ce-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship birthday query order product price - object)
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (contact-relationship ?p - person ?r - relationship)
    (birthday-of ?p - person ?b - birthday)
    (known-birthday ?p - person ?b - birthday)
    (ordered-on ?o - order ?b - birthday)
    (order-matches-query ?o - order ?q - query)
    (order-contains ?o - order ?p - product)
    (current-price ?p - product ?pr - price)
    (known-id ?x - object)
    (found-price ?p - product ?pr - price))

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
    :precondition (and (has-token phone ?t) (contact-relationship ?p ?r) (birthday-of ?p ?b) (not (task-completed)))
    :effect (known-birthday ?p ?b))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order ?p - person ?b - birthday)
    :precondition (and (has-token amazon ?t) (known-birthday ?p ?b) (ordered-on ?o ?b) (order-matches-query ?o ?q) (not (task-completed)))
    :effect (known-id ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-contains ?o ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?pr - price)
    :precondition (and (known-id ?p) (current-price ?p ?pr) (not (task-completed)))
    :effect (found-price ?p ?pr))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pr - price ?p - product)
    :precondition (and (found-price ?p ?pr) (not (task-completed)))
    :effect (task-completed))
)
