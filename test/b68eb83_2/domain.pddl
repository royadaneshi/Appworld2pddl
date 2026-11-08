(define (domain appworld-b68eb83-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query file-path directory location record - object
    email-thread attachment - record)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x - record)
    (thread-from ?th - email-thread ?p - person)
    (thread-matches ?th - email-thread ?q - query)
    (attachment-in-thread ?att - attachment ?th - email-thread)
    (saves-to ?att - attachment ?f - file-path)
    (downloaded ?att - attachment)
    (file-exists ?f - file-path)
    (decompresses-to ?f - file-path ?d - directory)
    (directory-exists ?d - directory)
    (trip-folders-in ?d - directory)
    (found-least-pictures ?l - location)
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

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-of file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?th ?q) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?att - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?th) (attachment-in-thread ?att ?th) (not (task-completed)))
    :effect (known-id ?att))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?ft - token ?gt - token ?f - file-path)
    :precondition (and (has-token gmail ?gt) (has-token file-system ?ft) (known-id ?att) (saves-to ?att ?f) (not (downloaded ?att)) (not (task-completed)))
    :effect (and (downloaded ?att) (file-exists ?f)))

  ; API: file_system.decompress_file
  (:action file-system-decompress-file
    :parameters (?f - file-path ?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (file-exists ?f) (decompresses-to ?f ?d) (not (task-completed)))
    :effect (directory-exists ?d))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory ?l - location)
    :precondition (and (has-token file-system ?t) (directory-exists ?d) (trip-folders-in ?d) (not (task-completed)))
    :effect (found-least-pictures ?l))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?l - location)
    :precondition (and (found-least-pictures ?l) (not (task-completed)))
    :effect (task-completed)))
