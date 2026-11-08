(define (domain appworld-aaa25aa-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person account username password token email query code relationship phone-number message inbox-email - object)
  (:constants phone gmail spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (relationship-of ?p - person ?r - relationship)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-from ?m - message ?p - person)
    (message-about ?m - message ?acc - account)
    (message-read ?m - message)
    (account-email ?acc - account ?e - email)
    (verification-code-of ?acc - account ?c - code)
    (reset-code-of ?acc - account ?c - code)
    (code-emailed ?c - code)
    (query-finds ?q - query ?em - inbox-email)
    (email-contains-code ?em - inbox-email ?c - code)
    (found-email ?em - inbox-email)
    (known-code ?c - code)
    (account-verified ?acc - account)
    (requested-password ?acc - account ?pw - password)
    (password-set ?acc - account ?pw - password)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (known-phone-number ?p ?n))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - message)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (message-from ?m ?p) (not (task-completed)))
    :effect (message-read ?m))

  ; API: spotify.send_verification_code
  (:action spotify-send-verification-code
    :parameters (?e - email ?acc - account ?m - message ?c - code)
    :precondition (and (account-email ?acc ?e) (message-read ?m) (message-about ?m ?acc) (verification-code-of ?acc ?c) (not (task-completed)))
    :effect (code-emailed ?c))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?em - inbox-email ?c - code)
    :precondition (and (has-token gmail ?t) (query-finds ?q ?em) (email-contains-code ?em ?c) (code-emailed ?c) (not (task-completed)))
    :effect (found-email ?em))

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?em - inbox-email ?t - token ?c - code)
    :precondition (and (has-token gmail ?t) (found-email ?em) (email-contains-code ?em ?c) (not (task-completed)))
    :effect (known-code ?c))

  ; API: spotify.verify_account
  (:action spotify-verify-account
    :parameters (?e - email ?c - code ?acc - account)
    :precondition (and (account-email ?acc ?e) (verification-code-of ?acc ?c) (known-code ?c) (not (task-completed)))
    :effect (account-verified ?acc))

  ; API: spotify.send_password_reset_code
  (:action spotify-send-password-reset-code
    :parameters (?e - email ?acc - account ?c - code)
    :precondition (and (account-email ?acc ?e) (reset-code-of ?acc ?c) (account-verified ?acc) (not (task-completed)))
    :effect (code-emailed ?c))

  ; API: spotify.reset_password
  (:action spotify-reset-password
    :parameters (?e - email ?c - code ?npw - password ?acc - account)
    :precondition (and (account-email ?acc ?e) (reset-code-of ?acc ?c) (known-code ?c) (requested-password ?acc ?npw) (not (task-completed)))
    :effect (password-set ?acc ?npw))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?acc - account ?npw - password)
    :precondition (and (account-verified ?acc) (password-set ?acc ?npw) (not (task-completed)))
    :effect (task-completed)))
