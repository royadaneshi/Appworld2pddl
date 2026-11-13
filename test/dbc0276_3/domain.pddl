(define (domain appworld-dbc0276-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship phone-number message wish-list - object)
  (:constants amazon phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-wish-list ?w - wish-list)
    (has-relationship ?p - person ?r - relationship)
    (is-partner ?p - person)
    (phone-number-of ?p - person ?ph - phone-number)
    (known-phone-number ?p - person ?ph - phone-number)
    (message-itemizes ?m - message ?w - wish-list)
    (text-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_wish_list
  (:action amazon-show-wish-list
    :parameters (?t - token ?w - wish-list)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (found-wish-list ?w))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?ph - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (phone-number-of ?p ?ph) (not (task-completed)))
    :effect (known-phone-number ?p ?ph))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person ?w - wish-list)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?ph) (found-wish-list ?w) (message-itemizes ?m ?w) (not (task-completed)))
    :effect (text-sent ?p ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?m - message)
    :precondition (and (text-sent ?p ?m) (is-partner ?p) (not (task-completed)))
    :effect (task-completed))
)
