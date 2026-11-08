(define (domain appworld-aaa25aa-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query code phone-number relationship text-message email-thread - object)
  (:constants phone gmail spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (phone-number-of ?p - person ?pn - phone-number)
    (known-phone-number ?p - person ?pn - phone-number)
    (message-from ?m - text-message ?p - person)
    (message-read ?m - text-message)
    (instruction-known)
    (supervisor-email ?e - email)
    (is-verification-code ?c - code)
    (is-reset-code ?c - code)
    (code-emailed ?c - code)
    (query-for-code ?q - query ?c - code)
    (thread-of ?th - email-thread ?c - code)
    (known-thread ?th - email-thread)
    (known-code ?c - code)
    (requested-new-password ?pw - password)
    (account-verified)
    (new-password-set)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?pn - phone-number)
    :precondition (and (not (task-completed)) (has-token phone ?t) (has-relationship ?p ?r) (phone-number-of ?p ?pn))
    :effect (known-phone-number ?p ?pn))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?pn - phone-number ?m - text-message ?p - person)
    :precondition (and (not (task-completed)) (has-token phone ?t) (known-phone-number ?p ?pn) (message-from ?m ?p))
    :effect (and (message-read ?m) (instruction-known)))

  ; API: spotify.send_verification_code
  (:action spotify-send-verification-code
    :parameters (?e - email ?c - code)
    :precondition (and (not (task-completed)) (instruction-known) (supervisor-email ?e) (is-verification-code ?c) (not (code-emailed ?c)))
    :effect (code-emailed ?c))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?c - code ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (code-emailed ?c) (query-for-code ?q ?c) (thread-of ?th ?c))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-thread ?th) (thread-of ?th ?c))
    :effect (known-code ?c))

  ; API: spotify.verify_account
  (:action spotify-verify-account
    :parameters (?e - email ?c - code)
    :precondition (and (not (task-completed)) (supervisor-email ?e) (is-verification-code ?c) (known-code ?c) (not (account-verified)))
    :effect (account-verified))

  ; API: spotify.send_password_reset_code
  (:action spotify-send-password-reset-code
    :parameters (?e - email ?c - code)
    :precondition (and (not (task-completed)) (account-verified) (supervisor-email ?e) (is-reset-code ?c) (not (code-emailed ?c)))
    :effect (code-emailed ?c))

  ; API: spotify.reset_password
  (:action spotify-reset-password
    :parameters (?e - email ?c - code ?npw - password)
    :precondition (and (not (task-completed)) (supervisor-email ?e) (is-reset-code ?c) (known-code ?c) (requested-new-password ?npw) (not (new-password-set)))
    :effect (new-password-set))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (account-verified) (new-password-set) (not (task-completed)))
    :effect (task-completed)))
