(define (domain appworld-6104387-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song artist file-path file-content - object)
  (:constants spotify file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (username-of ?p - person ?u - username)
    (known-username ?u - username)
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (song-artist ?s - song ?ar - artist)
    (known-song-title ?s - song)
    (known-id ?ar - artist)
    (known-artist-name ?ar - artist)
    (content-lists ?c - file-content ?s - song)
    (backup-created)
    (account-deleted ?a - app)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?p - person ?u - username)
    :precondition (and (username-of ?p ?u) (not (task-completed)))
    :effect (and (known-username ?u)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (known-username ?u) (passwords-known) (password-for spotify ?pw) (token-for spotify ?t) (not (has-token spotify ?t)) (not (account-deleted spotify)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (song-library-listed)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (album-library-listed)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (playlist-library-listed)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (song-library-listed) (album-library-listed) (playlist-library-listed) (song-artist ?s ?ar) (not (task-completed)))
    :effect (and (known-song-title ?s) (known-id ?ar)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist)
    :precondition (and (known-id ?ar) (not (task-completed)))
    :effect (and (known-artist-name ?ar)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (known-username ?u) (passwords-known) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?path - file-path ?t - token ?content - file-content ?s - song ?ar - artist)
    :precondition (and (has-token file-system ?t) (content-lists ?content ?s) (song-artist ?s ?ar) (known-song-title ?s) (known-artist-name ?ar) (not (backup-created)) (not (task-completed)))
    :effect (and (backup-created)))

  ; API: spotify.delete_account
  (:action spotify-delete-account
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (backup-created) (not (account-deleted spotify)) (not (task-completed)))
    :effect (and (account-deleted spotify) (not (has-token spotify ?t))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (backup-created) (account-deleted spotify) (not (task-completed)))
    :effect (and (task-completed)))
)
