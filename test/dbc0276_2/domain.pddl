(define (domain appworld-dbc0276-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product phone-number message relationship count - object
  )
  (:constants amazon phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-known)
    (in-wish-list ?p - product)
    (known-product-details ?p - product)
    (succ ?n1 - count ?n2 - count)
    (resolved-count ?n - count)
    (wish-list-size ?n - count)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?ph - phone-number)
    (known-phone ?p - person ?ph - phone-number)
    (message-itemizes-wish-list ?m - message)
    (text-sent ?ph - phone-number ?m - message)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-known))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?n - count ?n1 - count)
    :precondition (and (wish-list-known) (in-wish-list ?p) (not (known-product-details ?p)) (resolved-count ?n) (succ ?n ?n1) (not (task-completed)))
    :effect (and (known-product-details ?p) (not (resolved-count ?n)) (resolved-count ?n1))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?ph - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (phone-of ?p ?ph) (not (task-completed)))
    :effect (and (known-phone ?p ?ph))
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person ?n - count)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (message-itemizes-wish-list ?m) (wish-list-known) (wish-list-size ?n) (resolved-count ?n) (not (text-sent ?ph ?m)) (not (task-completed)))
    :effect (and (text-sent ?ph ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ph - phone-number ?m - message)
    :precondition (and (text-sent ?ph ?m) (message-itemizes-wish-list ?m) (not (task-completed)))
    :effect (and (task-completed))
  )
)
