(define (domain appworld-cf6abd2-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note content activity - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-finds ?q - query ?n - note)
    (known-id ?n - note)
    (content-read ?n - note)
    (item-of ?n - note ?act - activity)
    (unchecks ?c - content ?act - activity)
    (target-activity ?act - activity)
    (marked-not-done ?act - activity)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-finds ?q ?n) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (content-read ?n)
  )

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content ?act - activity)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (content-read ?n) (item-of ?n ?act) (unchecks ?c ?act) (not (task-completed)))
    :effect (marked-not-done ?act)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?act - activity)
    :precondition (and (target-activity ?act) (marked-not-done ?act) (not (task-completed)))
    :effect (task-completed)
  )
)
