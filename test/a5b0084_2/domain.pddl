(define (domain appworld-a5b0084-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query email-thread reset-code
    relationship phone-number message - object)
  (:constants spotify gmail phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (target-password ?pw - password)
    (reset-code-emailed)
    (known-thread ?th - email-thread)
    (known-reset-code ?c - reset-code)
    (password-reset ?a - app ?pw - password)
    (contacts-searched ?r - relationship)
    (relationship-of ?p - person ?r - relationship)
    (phone-number-of ?p - person ?n - phone-number)
    (message-contains ?m - message ?pw - password)
    (text-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.send_password_reset_code
  (:action spotify-send-password-reset-code
    :parameters (?e - email)
    :precondition (and (supervisor-email ?e) (not (task-completed)))
    :effect (reset-code-emailed))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (reset-code-emailed) (not (task-completed)))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - reset-code)
    :precondition (and (has-token gmail ?t) (known-thread ?th) (not (task-completed)))
    :effect (known-reset-code ?c))

  ; API: spotify.reset_password
  (:action spotify-reset-password
    :parameters (?e - email ?c - reset-code ?npw - password)
    :precondition (and (supervisor-email ?e) (known-reset-code ?c) (target-password ?npw) (not (task-completed)))
    :effect (password-reset spotify ?npw))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?r - relationship ?pw - password)
    :precondition (and (has-token phone ?t) (contacts-searched ?r) (relationship-of ?p ?r) (phone-number-of ?p ?n) (message-contains ?m ?pw) (password-reset spotify ?pw) (not (text-sent ?p ?m)) (not (task-completed)))
    :effect (text-sent ?p ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pw - password ?p1 - person ?p2 - person ?m - message)
    :precondition (and (target-password ?pw) (password-reset spotify ?pw) (text-sent ?p1 ?m) (text-sent ?p2 ?m) (not (= ?p1 ?p2)) (not (task-completed)))
    :effect (task-completed))
)
