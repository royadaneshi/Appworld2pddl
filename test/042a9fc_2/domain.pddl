(define (domain appworld-042a9fc-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship phone-number playlist song query - object
  )
  (:constants phone spotify - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (target-relationship ?r - relationship)
    (is-sibling ?p - person)
    (phone-number-of ?p - person ?n - phone-number)
    (siblings-known)
    (messages-read ?p - person)
    (suggested-by ?p - person ?s - song)
    (suggested-add ?s - song)
    (suggested-remove ?s - song)
    (song-query ?s - song ?q - query)
    (target-playlist ?pl - playlist)
    (known-playlist-id ?pl - playlist)
    (known-song-id ?s - song)
    (playlist-songs-known ?pl - playlist)
    (in-playlist ?pl - playlist ?s - song)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (target-relationship ?r) (not (task-completed)))
    :effect (siblings-known)
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person)
    :precondition (and (has-token phone ?t) (siblings-known) (is-sibling ?p) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (messages-read ?p)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (target-playlist ?pl) (not (task-completed)))
    :effect (known-playlist-id ?pl)
  )

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-playlist-id ?pl) (not (task-completed)))
    :effect (playlist-songs-known ?pl)
  )

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?p - person)
    :precondition (and (messages-read ?p) (suggested-by ?p ?s) (suggested-add ?s) (song-query ?s ?q) (not (task-completed)))
    :effect (known-song-id ?s)
  )

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?p - person)
    :precondition (and (has-token spotify ?t) (known-playlist-id ?pl) (known-song-id ?s) (messages-read ?p) (suggested-by ?p ?s) (suggested-add ?s) (not (in-playlist ?pl ?s)) (not (task-completed)))
    :effect (in-playlist ?pl ?s)
  )

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?p - person)
    :precondition (and (has-token spotify ?t) (known-playlist-id ?pl) (playlist-songs-known ?pl) (in-playlist ?pl ?s) (messages-read ?p) (suggested-by ?p ?s) (suggested-remove ?s) (not (task-completed)))
    :effect (not (in-playlist ?pl ?s))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pl - playlist ?sa - song ?sr - song)
    :precondition (and (target-playlist ?pl) (suggested-add ?sa) (suggested-remove ?sr) (in-playlist ?pl ?sa) (not (in-playlist ?pl ?sr)) (not (task-completed)))
    :effect (task-completed)
  )
)
