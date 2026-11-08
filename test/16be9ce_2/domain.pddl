(define (domain appworld-16be9ce-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship date price record - object
    order product - record
  )
  (:constants supervisor phone amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (relative ?p - person ?r - relationship)
    (birthday-of ?p - person ?d - date)
    (found-birthday ?p - person ?d - date)
    (ordered-on ?o - order ?d - date)
    (order-contains ?o - order ?pr - product)
    (product-price ?pr - product ?c - price)
    (known-id ?x - record)
    (found-price ?pr - product ?c - price)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?d - date)
    :precondition (and (has-token phone ?t) (relative ?p ?r) (birthday-of ?p ?d) (not (task-completed)))
    :effect (found-birthday ?p ?d)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?p - person ?d - date ?o - order)
    :precondition (and (has-token amazon ?t) (found-birthday ?p ?d) (ordered-on ?o ?d) (not (task-completed)))
    :effect (known-id ?o)
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?pr - product)
    :precondition (and (known-id ?o) (has-token amazon ?t) (order-contains ?o ?pr) (not (task-completed)))
    :effect (known-id ?pr)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?pr - product ?c - price)
    :precondition (and (known-id ?pr) (product-price ?pr ?c) (not (task-completed)))
    :effect (found-price ?pr ?c)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - price ?pr - product)
    :precondition (and (found-price ?pr ?c) (not (task-completed)))
    :effect (task-completed)
  )
)
