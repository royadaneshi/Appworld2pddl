(define (domain appworld-dcbd34b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query thread file-path content - object)
  (:constants gmail file-system supervisor - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (thread-matches ?th - thread ?q - query)
    (expense-thread ?th - thread)
    (known-id ?th - thread)
    (expenses-known)
    (headers-known ?f - file-path)
    (expense-content ?c - content)
    (file-updated ?f - file-path ?c - content)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (thread-matches ?th ?q))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (expense-thread ?th))
    :effect (and (expenses-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t))
    :effect (and (headers-known ?f)))

  ; API: file_system.update_file
  (:action file-system-update-file
    :parameters (?f - file-path ?c - content ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (headers-known ?f) (expenses-known) (expense-content ?c))
    :effect (and (file-updated ?f ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - file-path ?c - content)
    :precondition (and (not (task-completed)) (file-updated ?f ?c))
    :effect (and (task-completed)))
)
