(define (domain appworld-f323bae-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note path content flag - object)
  (:constants simple-note file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (query-matches ?q - query ?n - note)
    (known-id ?n - note)
    (read-content ?n - note)
    (derived-from ?c - content ?n - note)
    (is-dir ?d - path)
    (parent-dir ?f - path ?d - path)
    (directory-exists ?d - path)
    (file-created ?f - path ?c - content)
    (export-target ?f - path ?c - content))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-matches ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (read-content ?n)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - path ?t - token ?r - flag)
    :precondition (and (has-token file-system ?t) (is-dir ?d) (not (directory-exists ?d)) (not (task-completed)))
    :effect (and (directory-exists ?d)))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?f - path ?t - token ?c - content ?n - note ?d - path)
    :precondition (and (has-token file-system ?t) (read-content ?n) (derived-from ?c ?n) (parent-dir ?f ?d) (directory-exists ?d) (not (file-created ?f ?c)) (not (task-completed)))
    :effect (and (file-created ?f ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - path ?c - content)
    :precondition (and (export-target ?f ?c) (file-created ?f ?c) (not (task-completed)))
    :effect (and (task-completed))))
