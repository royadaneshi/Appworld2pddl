(define (domain appworld-6f4b9a5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note username password token query content - object)
  (:constants simple-note spotify - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?n - note)
    (found-song-log ?n - note)
    (found-release-months)
    (new-content-for ?n - note ?c - content)
    (note-updated ?n - note ?c - content)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (known-id ?n) (has-token simple-note ?t) (not (task-completed)))
    :effect (and (found-song-log ?n)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (found-release-months)))

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (known-id ?n) (found-song-log ?n) (found-release-months) (new-content-for ?n ?c) (has-token simple-note ?t) (not (task-completed)))
    :effect (and (note-updated ?n ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?c - content)
    :precondition (and (note-updated ?n ?c) (not (task-completed)))
    :effect (and (task-completed))))
