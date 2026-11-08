(define (domain appworld-9016950-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email name phone-number message - object
  )
  (:constants
    supervisor phone venmo - app
    parent-1 parent-2 - person
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (related ?p - person ?r - relationship)
    (contacts-searched ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contact-first-name ?p - person ?n - name)
    (contact-last-name ?p - person ?n - name)
    (contact-phone ?p - person ?n - phone-number)
    (signup-password ?pw - password)
    (notification-message ?m - message)
    (venmo-checked ?p - person)
    (has-venmo-account ?p - person)
    (venmo-account-created ?p - person)
    (text-sent ?p - person)
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
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?e - email ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (related ?p ?r) (contacts-searched ?r) (contact-email ?p ?e) (not (task-completed)))
    :effect (venmo-checked ?p)
  )

  ; API: venmo.signup
  (:action venmo-signup
    :parameters (?fn - name ?ln - name ?e - email ?pw - password ?p - person)
    :precondition (and (venmo-checked ?p) (not (has-venmo-account ?p)) (contact-first-name ?p ?fn) (contact-last-name ?p ?ln) (contact-email ?p ?e) (signup-password ?pw) (not (task-completed)))
    :effect (and (has-venmo-account ?p) (venmo-account-created ?p))
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (contact-phone ?p ?n) (notification-message ?m) (venmo-account-created ?p) (not (text-sent ?p)) (not (task-completed)))
    :effect (text-sent ?p)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (has-venmo-account parent-1) (has-venmo-account parent-2) (text-sent parent-1) (text-sent parent-2) (not (task-completed)))
    :effect (task-completed)
  )
)
