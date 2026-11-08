(define (domain appworld-13547f5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token phone-number message relationship - object)
  (:constants phone supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (has-phone-number ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-sent-to ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (has-phone-number ?p ?n) (not (task-completed)))
    :effect (and (known-phone-number ?p ?n)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (not (task-completed)))
    :effect (and (message-sent-to ?p ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?m - message)
    :precondition (and (message-sent-to ?p ?m) (not (task-completed)))
    :effect (and (task-completed))))
