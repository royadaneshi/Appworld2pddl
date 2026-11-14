(define (domain appworld-cf6abd2-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note content activity - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (query-matches ?q - query ?n - note)
    (known-id ?n - note)
    (content-of ?n - note ?c - content)
    (known-content ?n - note ?c - content)
    (activity-in-note ?act - activity ?n - note)
    (marks-done ?c2 - content ?act - activity ?c - content)
    (activity-done ?act - activity ?n - note)
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
    :precondition (and (profile-known)
                       (passwords-known)
                       (supervisor-username ?u)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (query-matches ?q ?n)
                       (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (has-token simple-note ?t)
                       (known-id ?n)
                       (content-of ?n ?c)
                       (not (task-completed)))
    :effect (known-content ?n ?c))

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c2 - content ?act - activity ?c - content)
    :precondition (and (has-token simple-note ?t)
                       (known-id ?n)
                       (known-content ?n ?c)
                       (activity-in-note ?act ?n)
                       (marks-done ?c2 ?act ?c)
                       (not (task-completed)))
    :effect (and (activity-done ?act ?n)
                 (not (content-of ?n ?c))
                 (content-of ?n ?c2)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
