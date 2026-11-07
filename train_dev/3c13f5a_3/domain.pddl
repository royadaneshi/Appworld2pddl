(define (domain appworld-3c13f5a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship directory-path substring entry-type file-path amount description count - object)
  (:constants
    venmo phone file-system - app
    c-all - count)
  (:predicates
    (profile-known)
    (passwords-known)
    (date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (is-roommate ?p - person)
    (roommate-email ?p - person ?e - email)
    (roommates-found)
    (roommate-query ?q - query)
    (roommate-relationship ?r - relationship)
    (home-directory ?d - directory-path)
    (bill-substring ?s - substring)
    (files-entry-type ?et - entry-type)
    (last-month-receipt ?fp - file-path)
    (known-file-path ?fp - file-path)
    (share-of ?fp - file-path ?amt - amount)
    (known-amount ?amt - amount)
    (note-text ?d - description)
    (request-sent ?p - person)
    (succ ?c1 - count ?c2 - count)
    (requests-sent-count ?c - count)
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
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (roommate-query ?q) (roommate-relationship ?r) (not (task-completed)))
    :effect (and (roommates-found)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?s - substring ?et - entry-type ?fp - file-path)
    :precondition (and (has-token file-system ?t) (home-directory ?d) (bill-substring ?s) (files-entry-type ?et) (date-known) (last-month-receipt ?fp) (not (task-completed)))
    :effect (and (known-file-path ?fp)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?fp - file-path ?t - token ?amt - amount)
    :precondition (and (has-token file-system ?t) (known-file-path ?fp) (share-of ?fp ?amt) (not (task-completed)))
    :effect (and (known-amount ?amt)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person ?c1 - count ?c2 - count)
    :precondition (and (has-token venmo ?t) (roommates-found) (is-roommate ?p) (roommate-email ?p ?e) (known-amount ?amt) (note-text ?d) (not (request-sent ?p)) (requests-sent-count ?c1) (succ ?c1 ?c2) (not (task-completed)))
    :effect (and (request-sent ?p) (not (requests-sent-count ?c1)) (requests-sent-count ?c2)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (requests-sent-count c-all) (not (task-completed)))
    :effect (and (task-completed))))
