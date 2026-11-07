(define (domain appworld-6c2c621-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token content file-path marker - object
    note - marker
  )
  (:constants
    simple-note file-system - app
    end-of-notes - marker
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor ?p - person)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (notes-listed)
    (content-of ?n - note ?c - content)
    (content-known ?n - note)
    (backup-file-of ?n - note ?f - file-path)
    (file-created ?f - file-path)
    (next-note ?m - marker ?n - marker)
    (export-cursor ?m - marker)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for simple-note ?pw)
      (token-for simple-note ?t)
      (not (has-token simple-note ?t))
    )
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token)
    :precondition (and
      (not (task-completed))
      (has-token simple-note ?t)
    )
    :effect (notes-listed)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and
      (not (task-completed))
      (has-token simple-note ?t)
      (notes-listed)
    )
    :effect (content-known ?n)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (supervisor-username ?u)
      (password-for file-system ?pw)
      (token-for file-system ?t)
      (not (has-token file-system ?t))
    )
    :effect (has-token file-system ?t)
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?f - file-path ?t - token ?c - content ?n - note ?next - marker)
    :precondition (and
      (not (task-completed))
      (has-token file-system ?t)
      (notes-listed)
      (backup-file-of ?n ?f)
      (content-of ?n ?c)
      (content-known ?n)
      (export-cursor ?n)
      (next-note ?n ?next)
      (not (file-created ?f))
    )
    :effect (and
      (file-created ?f)
      (not (export-cursor ?n))
      (export-cursor ?next)
    )
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (not (task-completed))
      (export-cursor end-of-notes)
    )
    :effect (task-completed)
  )
)
