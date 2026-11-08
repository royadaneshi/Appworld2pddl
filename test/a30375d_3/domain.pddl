(define (domain appworld-a30375d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query note quote - object)
  (:constants simple-note supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches-query ?q - query ?n - note)
    (known-id ?n - note)
    (quote-in-note ?qt - quote ?n - note)
    (found-quote ?qt - quote)
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
                       (username-for simple-note ?u)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (note-matches-query ?q ?n)
                       (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?qt - quote)
    :precondition (and (has-token simple-note ?t)
                       (known-id ?n)
                       (quote-in-note ?qt ?n)
                       (not (task-completed)))
    :effect (and (found-quote ?qt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?qt - quote)
    :precondition (and (found-quote ?qt)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
