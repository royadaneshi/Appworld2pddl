(define (domain appworld-cf6abd2-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note content activity - object)
  (:constants simple-note - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (owns-note ?p - person ?n - note)
    (matches-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-has-content ?n - note ?c - content)
    (found-content ?n - note ?c - content)
    (note-contains ?n - note ?act - activity)
    (content-marks-done ?new - content ?old - content ?act - activity)
    (activity-marked-done ?n - note ?act - activity)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (matches-query ?n ?q) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (note-has-content ?n ?c) (not (task-completed)))
    :effect (found-content ?n ?c))

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?new - content ?old - content ?act - activity)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (found-content ?n ?old) (note-contains ?n ?act) (content-marks-done ?new ?old ?act) (not (task-completed)))
    :effect (and (activity-marked-done ?n ?act) (not (note-has-content ?n ?old)) (note-has-content ?n ?new)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?act - activity)
    :precondition (and (activity-marked-done ?n ?act) (not (task-completed)))
    :effect (task-completed))
)
