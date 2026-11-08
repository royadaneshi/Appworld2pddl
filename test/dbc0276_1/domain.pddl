(define (domain appworld-dbc0276-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token product relationship phone-number message - object)
  (:constants amazon phone - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (wish-list-known)
    (known-id ?p - product)
    (price-known ?p - product)
    (has-relationship ?h - person ?r - relationship)
    (known-phone-number ?h - person ?n - phone-number)
    (message-itemizes ?m - message ?p - product)
    (text-sent ?h - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (wish-list-known) (known-id ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (known-id ?p) (not (task-completed)))
    :effect (and (price-known ?p)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?h - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?h ?r) (not (task-completed)))
    :effect (and (known-phone-number ?h ?n)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?h - person ?p - product)
    :precondition (and (has-token phone ?t) (known-phone-number ?h ?n) (wish-list-known) (message-itemizes ?m ?p) (price-known ?p) (not (task-completed)))
    :effect (and (text-sent ?h ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?h - person ?m - message)
    :precondition (and (text-sent ?h ?m) (not (task-completed)))
    :effect (and (task-completed))))
