(define (domain appworld-d194965-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note song playlist title count - object)
  (:constants
    simple-note spotify - app
    count-0 - count)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (song-in-note ?s - song ?n - note)
    (query-for-song ?q - query ?s - song)
    (known-song-id ?s - song)
    (playlist-created ?p - playlist)
    (playlist-title ?p - playlist ?ti - title)
    (song-in-playlist ?s - song ?p - playlist)
    (playlist-song-count ?p - playlist ?c - count)
    (note-song-count ?n - note ?c - count)
    (next-count ?c1 - count ?c2 - count)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  (:action simple-note-login
    ; API: simple_note.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  (:action simple-note-search-notes
    ; API: simple_note.search_notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  (:action simple-note-show-note
    ; API: simple_note.show_note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-read ?n)))

  (:action spotify-login
    ; API: spotify.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  (:action spotify-search-songs
    ; API: spotify.search_songs
    :parameters (?q - query ?s - song ?n - note)
    :precondition (and (note-read ?n) (song-in-note ?s ?n) (query-for-song ?q ?s) (not (task-completed)))
    :effect (and (known-song-id ?s)))

  (:action spotify-create-playlist
    ; API: spotify.create_playlist
    :parameters (?ti - title ?t - token ?p - playlist)
    :precondition (and (has-token spotify ?t) (not (playlist-created ?p)) (not (task-completed)))
    :effect (and (playlist-created ?p) (playlist-title ?p ?ti) (playlist-song-count ?p count-0)))

  (:action spotify-add-song-to-playlist
    ; API: spotify.add_song_to_playlist
    :parameters (?p - playlist ?s - song ?t - token ?c1 - count ?c2 - count)
    :precondition (and (has-token spotify ?t) (playlist-created ?p) (known-song-id ?s) (not (song-in-playlist ?s ?p)) (playlist-song-count ?p ?c1) (next-count ?c1 ?c2) (not (task-completed)))
    :effect (and (song-in-playlist ?s ?p) (not (playlist-song-count ?p ?c1)) (playlist-song-count ?p ?c2)))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?p - playlist ?ti - title ?n - note ?c - count)
    :precondition (and (playlist-created ?p) (playlist-title ?p ?ti) (note-read ?n) (playlist-song-count ?p ?c) (note-song-count ?n ?c) (not (task-completed)))
    :effect (and (task-completed)))
)
