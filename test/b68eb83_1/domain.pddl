(define (domain appworld-b68eb83-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email thread email-msg attachment file-path directory-path location flag - object)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (known-email ?p - person ?e - email)
    (sender-of ?th - thread ?p - person)
    (known-thread ?th - thread)
    (in-thread ?em - email-msg ?th - thread)
    (known-email-id ?em - email-msg)
    (attached-to ?at - attachment ?em - email-msg)
    (known-attachment ?at - attachment)
    (attachment-downloaded ?at - attachment ?fp - file-path)
    (file-exists ?fp - file-path)
    (decompressed-to ?fp - file-path ?dp - directory-path)
    (directory-exists ?dp - directory-path)
    (found-most-pictures-location ?loc - location)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-of gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.search_users
  (:action gmail-search-users
    :parameters (?q - query ?p - person ?e - email)
    :precondition (and (query-for ?q ?p) (not (known-email ?p ?e)) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?e - email ?att - flag ?p - person ?th - thread)
    :precondition (and (has-token gmail ?t) (known-email ?p ?e) (sender-of ?th ?p) (not (known-thread ?th)) (not (task-completed)))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?em - email-msg)
    :precondition (and (known-thread ?th) (has-token gmail ?t) (in-thread ?em ?th) (not (known-email-id ?em)) (not (task-completed)))
    :effect (known-email-id ?em))

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?em - email-msg ?t - token ?at - attachment)
    :precondition (and (known-email-id ?em) (has-token gmail ?t) (attached-to ?at ?em) (not (known-attachment ?at)) (not (task-completed)))
    :effect (known-attachment ?at))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-of file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?ft - token ?t - token ?fp - file-path)
    :precondition (and (known-attachment ?at) (has-token file-system ?ft) (has-token gmail ?t) (not (attachment-downloaded ?at ?fp)) (not (file-exists ?fp)) (not (task-completed)))
    :effect (and (attachment-downloaded ?at ?fp) (file-exists ?fp)))

  ; API: file_system.decompress_file
  (:action file-system-decompress-file
    :parameters (?fp - file-path ?ft - token ?dp - directory-path)
    :precondition (and (file-exists ?fp) (has-token file-system ?ft) (not (directory-exists ?dp)) (not (task-completed)))
    :effect (and (decompressed-to ?fp ?dp) (directory-exists ?dp)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?ft - token ?dp - directory-path ?rec - flag ?loc - location)
    :precondition (and (has-token file-system ?ft) (directory-exists ?dp) (not (task-completed)))
    :effect (found-most-pictures-location ?loc))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?loc - location)
    :precondition (and (found-most-pictures-location ?loc) (not (task-completed)))
    :effect (task-completed)))
