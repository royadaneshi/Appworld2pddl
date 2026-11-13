(define (domain appworld-d194965-1)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person entity username password token query title - object
    note song playlist - entity
  )
  (:constants supervisor simple-note spotify - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-for-note ?q - query ?n - note)
    (note-read ?n - note)
    (song-in-note ?n - note ?s - song)
    (query-for-song ?q - query ?s - song)
    (playlist-created ?p - playlist ?ti - title)
    (song-added ?p - playlist ?s - song)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-for-note ?q ?n) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (note-read ?n)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (token-for spotify ?t) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?n - note)
    :precondition (and (query-for-song ?q ?s) (song-in-note ?n ?s) (note-read ?n) (not (task-completed)))
    :effect (known-id ?s)
  )

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (known-id ?p)) (not (task-completed)))
    :effect (and (known-id ?p) (playlist-created ?p ?ti))
  )

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?p) (known-id ?s) (not (song-added ?p ?s)) (not (task-completed)))
    :effect (song-added ?p ?s)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - playlist ?ti - title)
    :precondition (and (playlist-created ?p ?ti) (forall (?s - song) (song-added ?p ?s)) (not (task-completed)))
    :effect (task-completed))

)
