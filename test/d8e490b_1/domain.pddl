(define (domain appworld-d8e490b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread attachment file-path directory-path flag - object)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (structure-known)
    (thread-matches ?q - query ?th - email-thread)
    (known-thread ?th - email-thread)
    (thread-shown ?th - email-thread)
    (attachment-of ?th - email-thread ?att - attachment)
    (slides ?att - attachment)
    (recording ?att - attachment)
    (target-path ?att - attachment ?p - file-path)
    (saved ?att - attachment ?p - file-path)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?r - flag)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (structure-known))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-thread ?th) (not (task-completed)))
    :effect (thread-shown ?th))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?ft - token ?t - token ?p - file-path ?th - email-thread)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (structure-known) (thread-shown ?th) (attachment-of ?th ?att) (target-path ?att ?p) (not (saved ?att ?p)) (not (task-completed)))
    :effect (saved ?att ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - attachment ?ps - file-path ?r - attachment ?pr - file-path)
    :precondition (and (slides ?s) (recording ?r) (saved ?s ?ps) (saved ?r ?pr) (not (task-completed)))
    :effect (task-completed))
)
