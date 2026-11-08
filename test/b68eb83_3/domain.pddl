(define (domain appworld-b68eb83-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email path flag location record - object
    thread attachment - record)
  (:constants phone gmail file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (thread-from ?th - thread ?p - person)
    (attachment-in ?at - attachment ?th - thread)
    (known-id ?x - record)
    (archive-of ?at - attachment ?f - path)
    (extract-dir ?f - path ?d - path)
    (downloaded ?at - attachment ?f - path)
    (file-exists ?f - path)
    (decompressed ?f - path ?d - path)
    (directory-exists ?d - path)
    (recursive-flag ?r - flag)
    (answer-slot ?l - location)
    (found-most-pictures ?l - location)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (query-for ?q ?p) (email-of ?p ?e))
    :effect (known-email ?p ?e))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t)
                       (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?e - email ?p - person ?th - thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t)
                       (known-email ?p ?e) (thread-from ?th ?p))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?at - attachment)
    :precondition (and (not (task-completed)) (has-token gmail ?t)
                       (known-id ?th) (attachment-in ?at ?th))
    :effect (known-id ?at))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t)
                       (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?ft - token ?t - token ?f - path)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?ft)
                       (known-id ?at) (archive-of ?at ?f) (not (file-exists ?f)))
    :effect (and (downloaded ?at ?f) (file-exists ?f)))

  ; API: file_system.decompress_file
  (:action file-system-decompress-file
    :parameters (?f - path ?ft - token ?d - path)
    :precondition (and (not (task-completed)) (has-token file-system ?ft)
                       (file-exists ?f) (extract-dir ?f ?d) (not (directory-exists ?d)))
    :effect (and (decompressed ?f ?d) (directory-exists ?d)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?ft - token ?d - path ?r - flag ?l - location)
    :precondition (and (not (task-completed)) (has-token file-system ?ft)
                       (directory-exists ?d) (recursive-flag ?r) (answer-slot ?l))
    :effect (found-most-pictures ?l))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?l - location ?at - attachment ?f - path ?d - path)
    :precondition (and (not (task-completed))
                       (downloaded ?at ?f) (decompressed ?f ?d) (found-most-pictures ?l))
    :effect (task-completed))
)
