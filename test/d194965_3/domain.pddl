(define (domain appworld-d194965-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query title - object
    entity - object
    note song playlist - entity
  )
  (:constants
    supervisor simple-note spotify - app
    song-1 song-2 song-3 - song
    random-playlist - playlist
    random-playlist-title - title
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (song-in-note ?s - song ?n - note)
    (song-query ?s - song ?q - query)
    (known-id ?x - entity)
    (note-read ?n - note)
    (playlist-created ?p - playlist)
    (playlist-titled ?p - playlist ?ti - title)
    (song-in-playlist ?s - song ?p - playlist)
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
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (known-id ?n) (has-token simple-note ?t) (not (task-completed)))
    :effect (and (note-read ?n))
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t))
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?n - note)
    :precondition (and (note-read ?n) (song-in-note ?s ?n) (song-query ?s ?q) (not (task-completed)))
    :effect (and (known-id ?s))
  )

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (playlist-created ?p)) (not (task-completed)))
    :effect (and (playlist-created ?p) (playlist-titled ?p ?ti) (known-id ?p))
  )

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?p - playlist ?s - song ?t - token)
    :precondition (and (known-id ?p) (known-id ?s) (has-token spotify ?t) (not (song-in-playlist ?s ?p)) (not (task-completed)))
    :effect (and (song-in-playlist ?s ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (playlist-created random-playlist) (playlist-titled random-playlist random-playlist-title) (song-in-playlist song-1 random-playlist) (song-in-playlist song-2 random-playlist) (song-in-playlist song-3 random-playlist) (not (task-completed)))
    :effect (and (task-completed))
  )
)
