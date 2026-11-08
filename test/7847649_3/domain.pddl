(define (domain appworld-7847649-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note count - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches-query ?n - note ?q - query)
    (known-id ?n - note)
    (done-count-of ?n - note ?c - count)
    (found-done-count ?n - note ?c - count)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (note-matches-query ?n ?q)
                       (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - count)
    :precondition (and (has-token simple-note ?t)
                       (known-id ?n)
                       (done-count-of ?n ?c)
                       (not (task-completed)))
    :effect (and (found-done-count ?n ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count ?n - note)
    :precondition (and (found-done-count ?n ?c)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
