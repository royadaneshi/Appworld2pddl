(define (domain appworld-d6ac34d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note username password token query title content tag-list pinned-flag - object
  )
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-matches ?q - query ?n - note)
    (known-id ?n - note)
    (found-note-details ?n - note)
    (today-version ?src - note ?ti - title ?c - content ?tg - tag-list ?p - pinned-flag)
    (note-created ?n - note)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-matches ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (found-note-details ?n))
  )

  ; API: simple_note.create_note
  (:action simple-note-create-note
    :parameters (?ti - title ?c - content ?t - token ?tg - tag-list ?p - pinned-flag ?new - note ?src - note)
    :precondition (and (has-token simple-note ?t) (found-note-details ?src) (today-version ?src ?ti ?c ?tg ?p) (not (= ?new ?src)) (not (known-id ?new)) (not (note-created ?new)) (not (task-completed)))
    :effect (and (note-created ?new))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note)
    :precondition (and (note-created ?n) (not (task-completed)))
    :effect (and (task-completed))
  )
)
