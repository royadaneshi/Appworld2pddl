(define (domain appworld-042a9fc-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship phone-number text-message playlist song query - object)
  (:constants supervisor phone spotify - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (relationship-of ?p - person ?r - relationship)
    (has-phone ?p - person ?n - phone-number)
    (sent-message ?p - person ?m - text-message)
    (suggests-add ?m - text-message ?s - song)
    (suggests-remove ?m - text-message ?s - song)
    (song-query ?s - song ?q - query)
    (contacts-searched ?r - relationship)
    (read-message ?m - text-message)
    (known-playlist ?pl - playlist)
    (playlist-contents-known ?pl - playlist)
    (known-song-id ?s - song)
    (in-playlist ?pl - playlist ?s - song)
    (added ?pl - playlist ?s - song)
    (removed ?pl - playlist ?s - song)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (contacts-searched ?r)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?r - relationship ?m - text-message)
    :precondition (and (has-token phone ?t) (contacts-searched ?r) (relationship-of ?p ?r) (has-phone ?p ?n) (sent-message ?p ?m) (not (task-completed)))
    :effect (and (read-message ?m)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (token-for spotify ?t) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (known-playlist ?pl)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-playlist ?pl) (not (task-completed)))
    :effect (and (playlist-contents-known ?pl)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?m - text-message)
    :precondition (and (song-query ?s ?q) (read-message ?m) (suggests-add ?m ?s) (not (task-completed)))
    :effect (and (known-song-id ?s)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?m - text-message)
    :precondition (and (has-token spotify ?t) (known-playlist ?pl) (playlist-contents-known ?pl) (known-song-id ?s) (read-message ?m) (suggests-add ?m ?s) (not (in-playlist ?pl ?s)) (not (task-completed)))
    :effect (and (in-playlist ?pl ?s) (added ?pl ?s)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?m - text-message)
    :precondition (and (has-token spotify ?t) (known-playlist ?pl) (playlist-contents-known ?pl) (in-playlist ?pl ?s) (read-message ?m) (suggests-remove ?m ?s) (not (task-completed)))
    :effect (and (not (in-playlist ?pl ?s)) (removed ?pl ?s)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pl - playlist ?sa - song ?sr - song)
    :precondition (and (added ?pl ?sa) (removed ?pl ?sr) (in-playlist ?pl ?sa) (not (in-playlist ?pl ?sr)) (not (task-completed)))
    :effect (and (task-completed)))
)
