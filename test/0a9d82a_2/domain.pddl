(define (domain appworld-0a9d82a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note habit streak-days - object)
  (:constants supervisor simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (search-done ?q - query)
    (found-by ?q - query ?n - note)
    (habit-log ?n - note ?h - habit)
    (note-read ?n - note)
    (streak-known ?h - habit ?d - streak-days)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token simple-note ?t))
    :effect (search-done ?q))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?q - query ?h - habit ?d - streak-days)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (search-done ?q) (found-by ?q ?n) (habit-log ?n ?h))
    :effect (and (note-read ?n) (streak-known ?h ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - streak-days ?h - habit ?n1 - note ?n2 - note)
    :precondition (and (not (task-completed)) (streak-known ?h ?d) (habit-log ?n1 ?h) (habit-log ?n2 ?h) (note-read ?n1) (note-read ?n2) (not (= ?n1 ?n2)))
    :effect (task-completed))
)
