(define (domain appworld-042a9fc-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person entity username password token phone-number relationship query - object
    playlist song - entity)
  (:constants
    phone spotify - app
    roadtrip-playlist - playlist
    song-add-1 song-add-2 song-remove-1 song-remove-2 - song)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?n - phone-number)
    (contacts-known ?r - relationship)
    (suggestions-read ?p - person)
    (suggests-add ?p - person ?s - song)
    (suggests-remove ?p - person ?s - song)
    (search-query ?s - song ?q - query)
    (known-id ?x - entity)
    (playlist-songs-known ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (contacts-known ?r)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?r - relationship)
    :precondition (and (has-token phone ?t) (contacts-known ?r) (has-relationship ?p ?r) (phone-of ?p ?n) (not (task-completed)))
    :effect (and (suggestions-read ?p)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (known-id ?pl)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (not (task-completed)))
    :effect (and (playlist-songs-known ?pl)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?p - person)
    :precondition (and (search-query ?s ?q) (suggestions-read ?p) (suggests-add ?p ?s) (not (task-completed)))
    :effect (and (known-id ?s)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?p - person)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (known-id ?s) (suggestions-read ?p) (suggests-add ?p ?s) (not (in-playlist ?s ?pl)) (not (task-completed)))
    :effect (and (in-playlist ?s ?pl)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?p - person)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (playlist-songs-known ?pl) (suggestions-read ?p) (suggests-remove ?p ?s) (in-playlist ?s ?pl) (not (task-completed)))
    :effect (and (not (in-playlist ?s ?pl))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (in-playlist song-add-1 roadtrip-playlist) (in-playlist song-add-2 roadtrip-playlist) (not (in-playlist song-remove-1 roadtrip-playlist)) (not (in-playlist song-remove-2 roadtrip-playlist)) (not (task-completed)))
    :effect (and (task-completed)))
)
