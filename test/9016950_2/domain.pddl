(define (domain appworld-9016950-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number name relationship message - object)
  (:constants venmo phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contacts-searched)
    (is-roommate ?p - person)
    (first-name-of ?p - person ?n - name)
    (last-name-of ?p - person ?n - name)
    (email-of ?p - person ?e - email)
    (phone-of ?p - person ?ph - phone-number)
    (signup-password ?pw - password)
    (notification-message ?m - message)
    (venmo-account-checked ?p - person)
    (has-venmo-account ?p - person)
    (venmo-account-created ?p - person)
    (text-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (contacts-searched)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?e - email ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-searched) (is-roommate ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (and (venmo-account-checked ?p)))

  ; API: venmo.signup
  (:action venmo-signup
    :parameters (?fn - name ?ln - name ?e - email ?pw - password ?p - person)
    :precondition (and (contacts-searched) (is-roommate ?p) (first-name-of ?p ?fn) (last-name-of ?p ?ln) (email-of ?p ?e) (signup-password ?pw) (venmo-account-checked ?p) (not (has-venmo-account ?p)) (not (task-completed)))
    :effect (and (has-venmo-account ?p) (venmo-account-created ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (contacts-searched) (is-roommate ?p) (phone-of ?p ?ph) (notification-message ?m) (venmo-account-created ?p) (not (text-sent ?p)) (not (task-completed)))
    :effect (and (text-sent ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (not (= ?p1 ?p2)) (is-roommate ?p1) (is-roommate ?p2) (venmo-account-created ?p1) (venmo-account-created ?p2) (text-sent ?p1) (text-sent ?p2) (not (task-completed)))
    :effect (and (task-completed)))
)
