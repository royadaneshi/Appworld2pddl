(define (domain appworld-a5b0084-1)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token email code query email-thread relationship phone-number message - object)
  (:constants amazon gmail phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (account-email ?a - app ?e - email)
    (target-password ?a - app ?pw - password)
    (reset-code-sent ?a - app)
    (reset-code-query ?q - query)
    (known-id ?th - email-thread)
    (found-reset-code ?a - app ?c - code)
    (password-changed ?a - app ?pw - password)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?n - phone-number)
    (contacts-found ?r - relationship)
    (message-contains ?m - message ?pw - password)
    (text-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.send_password_reset_code
  (:action amazon-send-password-reset-code
    :parameters (?e - email)
    :precondition (and (not (task-completed)) (account-email amazon ?e))
    :effect (reset-code-sent amazon))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (reset-code-query ?q) (reset-code-sent amazon))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th))
    :effect (found-reset-code amazon ?c))

  ; API: amazon.reset_password
  (:action amazon-reset-password
    :parameters (?e - email ?c - code ?np - password)
    :precondition (and (not (task-completed)) (account-email amazon ?e) (reset-code-sent amazon) (found-reset-code amazon ?c) (target-password amazon ?np))
    :effect (password-changed amazon ?np))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t))
    :effect (contacts-found ?r))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?r - relationship ?np - password)
    :precondition (and (not (task-completed)) (has-token phone ?t) (contacts-found ?r) (has-relationship ?p ?r) (phone-of ?p ?n) (password-changed amazon ?np) (message-contains ?m ?np) (not (text-sent ?p)))
    :effect (text-sent ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?np - password)
    :precondition (and (not (task-completed)) (target-password amazon ?np) (password-changed amazon ?np)
                       (forall (?p - person ?r - relationship) (imply (has-relationship ?p ?r) (text-sent ?p))))
    :effect (task-completed))

)
