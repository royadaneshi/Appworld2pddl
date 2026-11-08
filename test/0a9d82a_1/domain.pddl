(define (domain appworld-0a9d82a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note habit streak - object)
  (:constants simple-note - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (habit-query ?q - query)
    (habit-log ?n - note)
    (habit-logs-listed)
    (read-note ?n - note)
    (target-habit ?h - habit)
    (longest-streak-of ?h - habit ?s - streak)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (habit-query ?q) (not (habit-logs-listed)))
    :effect (habit-logs-listed))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (habit-logs-listed) (habit-log ?n) (not (read-note ?n)))
    :effect (read-note ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?s - streak ?h - habit ?n1 - note ?n2 - note)
    :precondition (and (not (task-completed)) (target-habit ?h) (longest-streak-of ?h ?s) (habit-log ?n1) (habit-log ?n2) (not (= ?n1 ?n2)) (read-note ?n1) (read-note ?n2))
    :effect (task-completed)))
