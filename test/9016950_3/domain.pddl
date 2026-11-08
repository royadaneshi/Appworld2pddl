(define (domain appworld-9016950-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship
    first-name last-name email phone-number message - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (is-parent ?p - person)
    (parents-relationship ?r - relationship)
    (relationships-known)
    (parent-contacts-known)
    (contact-first-name ?p - person ?fn - first-name)
    (contact-last-name ?p - person ?ln - last-name)
    (contact-email ?p - person ?e - email)
    (contact-phone ?p - person ?ph - phone-number)
    (new-account-password ?pw - password)
    (notification-message ?m - message)
    (lacks-venmo-account ?p - person)
    (venmo-status-known ?p - person)
    (venmo-account-created ?p - person)
    (text-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.show_contact_relationships
  (:action phone-show-contact-relationships
    :parameters (?t - token)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (relationships-known))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (relationships-known) (parents-relationship ?r) (not (task-completed)))
    :effect (parent-contacts-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?e - email ?p - person)
    :precondition (and (has-token venmo ?t) (parent-contacts-known) (is-parent ?p) (contact-email ?p ?e) (not (task-completed)))
    :effect (venmo-status-known ?p))

  ; API: venmo.signup
  (:action venmo-signup
    :parameters (?fn - first-name ?ln - last-name ?e - email ?pw - password ?p - person)
    :precondition (and (parent-contacts-known) (is-parent ?p) (venmo-status-known ?p) (lacks-venmo-account ?p) (contact-first-name ?p ?fn) (contact-last-name ?p ?ln) (contact-email ?p ?e) (new-account-password ?pw) (not (venmo-account-created ?p)) (not (task-completed)))
    :effect (venmo-account-created ?p))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (parent-contacts-known) (is-parent ?p) (contact-phone ?p ?ph) (notification-message ?m) (venmo-account-created ?p) (not (text-sent ?p)) (not (task-completed)))
    :effect (text-sent ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (is-parent ?p1) (is-parent ?p2) (not (= ?p1 ?p2)) (venmo-account-created ?p1) (venmo-account-created ?p2) (text-sent ?p1) (text-sent ?p2) (not (task-completed)))
    :effect (task-completed))
)
