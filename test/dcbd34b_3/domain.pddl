(define (domain appworld-dcbd34b-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread file content - object)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?th - email-thread)
    (found-expense-details)
    (known-headers ?f - file)
    (file-filled ?f - file ?c - content)
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

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?th) (not (task-completed)))
    :effect (found-expense-details))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (known-headers ?f))

  ; API: file_system.update_file
  (:action file-system-update-file
    :parameters (?f - file ?c - content ?t - token)
    :precondition (and (has-token file-system ?t) (known-headers ?f) (found-expense-details) (not (task-completed)))
    :effect (file-filled ?f ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - file ?c - content)
    :precondition (and (file-filled ?f ?c) (not (task-completed)))
    :effect (task-completed))
)
