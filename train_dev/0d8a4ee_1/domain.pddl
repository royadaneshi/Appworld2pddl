(define (domain appworld-0d8a4ee-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number relationship message - object)
  (:constants
    phone venmo - app
    parent-1 parent-2 sibling-1 sibling-2 - person
    message-please-get-on-venmo - message)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (relation ?p - person ?r - relationship)
    (contacts-searched ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contact-phone ?p - person ?n - phone-number)
    (has-venmo-account ?p - person)
    (venmo-checked ?p - person)
    (message-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (contacts-searched ?r)) (not (task-completed)))
    :effect (and (contacts-searched ?r)))

  ; API: venmo.show_profile
  (:action venmo-show-profile
    :parameters (?t - token ?e - email ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (contact-email ?p ?e) (relation ?p ?r) (contacts-searched ?r) (not (venmo-checked ?p)) (not (task-completed)))
    :effect (and (venmo-checked ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (contact-phone ?p ?n) (venmo-checked ?p) (not (has-venmo-account ?p)) (not (message-sent ?p ?m)) (not (task-completed)))
    :effect (and (message-sent ?p ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (venmo-checked parent-1) (venmo-checked parent-2) (venmo-checked sibling-1) (venmo-checked sibling-2) (message-sent parent-1 message-please-get-on-venmo) (message-sent sibling-1 message-please-get-on-venmo) (not (task-completed)))
    :effect (and (task-completed))))
