(define (domain appworld-3c13f5a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship
    directory-path substring entry-type file-path amount note - object)
  (:constants venmo phone file-system - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (date-known)
    (roommate ?p - person)
    (contact-email ?p - person ?e - email)
    (contacts-searched)
    (found-receipt-file ?f - file-path)
    (known-bill-share ?amt - amount)
    (request-sent ?p - person ?amt - amount ?n - note)
    (requests-sent)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  (:action phone-get-current-date-and-time
    ; API: phone.get_current_date_and_time
    :parameters ()
    :precondition (not (task-completed))
    :effect (date-known))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched))

  (:action file-system-login
    ; API: file_system.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for file-system ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  (:action file-system-show-directory
    ; API: file_system.show_directory
    :parameters (?t - token ?d - directory-path ?s - substring ?et - entry-type ?f - file-path)
    :precondition (and (has-token file-system ?t) (date-known) (not (task-completed)))
    :effect (found-receipt-file ?f))

  (:action file-system-show-file
    ; API: file_system.show_file
    :parameters (?f - file-path ?t - token ?amt - amount)
    :precondition (and (has-token file-system ?t) (found-receipt-file ?f) (not (task-completed)))
    :effect (known-bill-share ?amt))

  (:action venmo-login
    ; API: venmo.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  (:action venmo-create-payment-request
    ; API: venmo.create_payment_request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (has-token venmo ?t) (roommate ?p) (contact-email ?p ?e)
                       (contacts-searched) (known-bill-share ?amt)
                       (not (request-sent ?p ?amt ?n)) (not (task-completed)))
    :effect (and (request-sent ?p ?amt ?n) (requests-sent)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters ()
    :precondition (and (requests-sent) (not (task-completed)))
    :effect (task-completed)))
