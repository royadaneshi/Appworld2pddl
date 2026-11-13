(define (domain appworld-a5b0084-3)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token email code query relationship phone-number message email-thread - object)
  (:constants spotify gmail phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (supervisor-email ?e - email)
    (reset-code-sent ?a - app)
    (thread-matches ?th - email-thread ?q - query)
    (known-id ?th - email-thread)
    (carries-code ?th - email-thread ?c - code)
    (reset-code-for ?c - code ?a - app)
    (found-reset-code ?c - code)
    (desired-password ?a - app ?pw - password)
    (password-changed ?a - app ?pw - password)
    (roommate-relationship ?r - relationship)
    (is-roommate ?p - person)
    (contact-phone ?p - person ?n - phone-number)
    (roommates-found)
    (message-contains ?m - message ?pw - password)
    (texted ?p - person ?pw - password))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.send_password_reset_code
  (:action spotify-send-password-reset-code
    :parameters (?e - email)
    :precondition (and (not (task-completed)) (supervisor-email ?e))
    :effect (reset-code-sent spotify))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (reset-code-sent spotify) (thread-matches ?th ?q))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (carries-code ?th ?c))
    :effect (found-reset-code ?c))

  ; API: spotify.reset_password
  (:action spotify-reset-password
    :parameters (?e - email ?c - code ?new - password)
    :precondition (and (not (task-completed)) (supervisor-email ?e) (reset-code-sent spotify) (found-reset-code ?c) (reset-code-for ?c spotify) (desired-password spotify ?new))
    :effect (password-changed spotify ?new))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (roommate-relationship ?r))
    :effect (roommates-found))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?pw - password)
    :precondition (and (not (task-completed)) (has-token phone ?t) (roommates-found) (is-roommate ?p) (contact-phone ?p ?n) (message-contains ?m ?pw) (password-changed spotify ?pw) (not (texted ?p ?pw)))
    :effect (texted ?p ?pw))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pw - password)
    :precondition (and (not (task-completed)) (desired-password spotify ?pw) (password-changed spotify ?pw)
                       (forall (?p - person) (imply (is-roommate ?p) (texted ?p ?pw))))
    :effect (task-completed))

)
