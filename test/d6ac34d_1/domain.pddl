(define (domain appworld-d6ac34d-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note title content taglist pinflag - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (matches-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-details-known ?n - note)
    (previous-log ?n - note ?prev - note)
    (derived-title ?from - note ?ti - title)
    (derived-content ?from - note ?c - content)
    (note-tags ?n - note ?tg - taglist)
    (note-pinned ?n - note ?p - pinflag)
    (note-added ?n - note)
    (note-title ?n - note ?ti - title)
    (note-content ?n - note ?c - content)
    (habit-log-added-for-today))

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
    :precondition (and (has-token simple-note ?t) (matches-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-details-known ?n)))

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?title - title ?content - content ?t - token ?tags - taglist ?pinned - pinflag ?n - note ?prev - note)
    :precondition (and (has-token simple-note ?t) (previous-log ?n ?prev) (note-details-known ?prev) (derived-title ?prev ?title) (derived-content ?prev ?content) (note-tags ?prev ?tags) (note-pinned ?prev ?pinned) (not (note-added ?n)) (not (task-completed)))
    :effect (and (note-added ?n) (note-title ?n ?title) (note-content ?n ?content) (note-tags ?n ?tags) (note-pinned ?n ?pinned) (habit-log-added-for-today)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (habit-log-added-for-today) (not (task-completed)))
    :effect (and (task-completed))))
