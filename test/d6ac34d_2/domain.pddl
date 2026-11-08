(define (domain appworld-d6ac34d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note title content tags pinned-flag - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-finds ?q - query ?n - note)
    (known-id ?n - note)
    (note-details-known ?n - note)
    (title-for-today ?ti - title ?y - note)
    (content-for-today ?c - content ?y - note)
    (tags-of ?tg - tags ?y - note)
    (pinned-of ?p - pinned-flag ?y - note)
    (note-created ?n - note)
    (note-has-title ?n - note ?ti - title)
    (note-has-content ?n - note ?c - content)
    (note-has-tags ?n - note ?tg - tags)
    (note-has-pinned ?n - note ?p - pinned-flag)
    (task-completed))

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
    :precondition (and (has-token simple-note ?t) (query-finds ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-details-known ?n)))

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?ti - title ?c - content ?t - token ?tg - tags ?p - pinned-flag ?n - note ?y - note)
    :precondition (and (has-token simple-note ?t) (note-details-known ?y)
      (title-for-today ?ti ?y) (content-for-today ?c ?y) (tags-of ?tg ?y) (pinned-of ?p ?y)
      (not (= ?n ?y)) (not (note-created ?n)) (not (task-completed)))
    :effect (and (note-created ?n) (note-has-title ?n ?ti) (note-has-content ?n ?c) (note-has-tags ?n ?tg) (note-has-pinned ?n ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?ti - title ?c - content ?tg - tags ?p - pinned-flag)
    :precondition (and (note-created ?n) (note-has-title ?n ?ti) (note-has-content ?n ?c) (note-has-tags ?n ?tg) (note-has-pinned ?n ?p) (not (task-completed)))
    :effect (and (task-completed)))
)
