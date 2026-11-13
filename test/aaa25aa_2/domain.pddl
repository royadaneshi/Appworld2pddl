(define (domain appworld-aaa25aa-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number relationship
    text-message email-thread code query - object
  )
  (:constants supervisor phone gmail venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (supervisor-email ?e - email)
    (new-password ?pw - password)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?n - phone-number)
    (known-phone ?p - person ?n - phone-number)
    (message-from ?m - text-message ?p - person)
    (message-requests ?m - text-message ?e - email)
    (message-read ?m - text-message)
    (account-setup-requested ?e - email)
    (verification-thread-for ?e - email ?th - email-thread)
    (reset-thread-for ?e - email ?th - email-thread)
    (thread-exists ?th - email-thread)
    (query-finds ?q - query ?th - email-thread)
    (known-id ?th - email-thread)
    (code-in-thread ?c - code ?th - email-thread)
    (known-code ?c - code)
    (verification-code-for ?c - code ?e - email)
    (reset-code-for ?c - code ?e - email)
    (account-verified ?e - email)
    (password-set ?e - email ?pw - password)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (phone-of ?p ?n)
                       (not (task-completed)))
    :effect (known-phone ?p ?n)
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - text-message ?e - email)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (message-from ?m ?p)
                       (message-requests ?m ?e) (not (task-completed)))
    :effect (and (message-read ?m) (account-setup-requested ?e))
  )

  ; API: venmo.send_verification_code
  (:action venmo-send-verification-code
    :parameters (?e - email ?th - email-thread)
    :precondition (and (account-setup-requested ?e) (verification-thread-for ?e ?th)
                       (not (task-completed)))
    :effect (thread-exists ?th)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (query-finds ?q ?th) (thread-exists ?th)
                       (not (task-completed)))
    :effect (known-id ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - code)
    :precondition (and (has-token gmail ?t) (known-id ?th) (code-in-thread ?c ?th)
                       (not (task-completed)))
    :effect (known-code ?c)
  )

  ; API: venmo.verify_account
  (:action venmo-verify-account
    :parameters (?e - email ?c - code)
    :precondition (and (known-code ?c) (verification-code-for ?c ?e) (not (task-completed)))
    :effect (account-verified ?e)
  )

  ; API: venmo.send_password_reset_code
  (:action venmo-send-password-reset-code
    :parameters (?e - email ?th - email-thread)
    :precondition (and (account-setup-requested ?e) (reset-thread-for ?e ?th)
                       (not (task-completed)))
    :effect (thread-exists ?th)
  )

  ; API: venmo.reset_password
  (:action venmo-reset-password
    :parameters (?e - email ?c - code ?npw - password)
    :precondition (and (known-code ?c) (reset-code-for ?c ?e) (new-password ?npw)
                       (not (task-completed)))
    :effect (password-set ?e ?npw)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?e - email ?npw - password)
    :precondition (and (supervisor-email ?e) (new-password ?npw) (account-verified ?e)
                       (password-set ?e ?npw) (not (task-completed)))
    :effect (task-completed)
  )
)
