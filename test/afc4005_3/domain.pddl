(define (domain appworld-afc4005-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note duration - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?q - query ?n - note)
    (duration-of ?n - note ?d - duration)
    (known-id ?n - note)
    (found-duration ?d - duration)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?d - duration)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (duration-of ?n ?d) (not (task-completed)))
    :effect (found-duration ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - duration)
    :precondition (and (found-duration ?d) (not (task-completed)))
    :effect (task-completed)))
