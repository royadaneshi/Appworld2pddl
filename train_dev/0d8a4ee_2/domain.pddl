(define (domain appworld-0d8a4ee-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship phone-number email message - object)
  (:constants
    phone venmo - app
    sibling-1 person-1 sibling-2 person-2 roommate-1 - person
    msg-get-on-venmo-please - message)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?n - phone-number)
    (email-of ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (venmo-status-known ?p - person)
    (no-venmo-account ?p - person)
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
    :precondition (and (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r)
                       (phone-of ?p ?n) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-email ?p ?e)))

  ; API: venmo.show_profile
  (:action venmo-show-profile
    :parameters (?t - token ?e - email ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (not (task-completed)))
    :effect (and (venmo-status-known ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n)
                       (venmo-status-known ?p) (no-venmo-account ?p)
                       (not (message-sent ?p ?m)) (not (task-completed)))
    :effect (and (message-sent ?p ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (venmo-status-known sibling-1) (venmo-status-known person-1) (venmo-status-known sibling-2) (venmo-status-known person-2) (venmo-status-known roommate-1)
                       (message-sent person-1 msg-get-on-venmo-please) (message-sent roommate-1 msg-get-on-venmo-please)
                       (not (task-completed)))
    :effect (and (task-completed))))
