(define (domain appworld-6c2c621-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token file-path content - object
    note-marker - object
    note - note-marker)
  (:constants
    simple-note file-system - app
    no-more-notes - note-marker)
  (:predicates
    (passwords-known)
    (profile-known)
    (task-completed)
    (supervisor ?p - person)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (notes-listed)
    (known-content ?n - note)
    (note-content ?n - note ?c - content)
    (note-file-path ?n - note ?fp - file-path)
    (next-note ?n - note ?m - note-marker)
    (all-exported-before ?m - note-marker)
    (note-exported ?n - note)
    (file-created ?fp - file-path))

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

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (supervisor-username ?u)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (supervisor-username ?u)
                       (password-for file-system ?pw)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token)
    :precondition (and (has-token simple-note ?t) (not (task-completed)))
    :effect (and (notes-listed)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (notes-listed) (not (task-completed)))
    :effect (and (known-content ?n)))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?fp - file-path ?t - token ?c - content ?n - note ?next - note-marker)
    :precondition (and (has-token file-system ?t)
                       (notes-listed)
                       (known-content ?n)
                       (note-content ?n ?c)
                       (note-file-path ?n ?fp)
                       (next-note ?n ?next)
                       (all-exported-before ?n)
                       (not (note-exported ?n))
                       (not (file-created ?fp))
                       (not (task-completed)))
    :effect (and (file-created ?fp) (note-exported ?n) (all-exported-before ?next)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (all-exported-before no-more-notes) (not (task-completed)))
    :effect (and (task-completed)))
)
