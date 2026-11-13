(define (domain appworld-6104387-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song artist file-path content - object)
  (:constants spotify file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (song-library-listed)
    (album-library-listed)
    (playlist-library-listed)
    (found-title ?s - song)
    (artist-of ?ar - artist ?s - song)
    (known-id ?ar - artist)
    (found-artist-name ?ar - artist)
    (backup-path ?p - file-path)
    (csv-of ?c - content ?s - song ?ar - artist)
    (backup-file-created)
    (spotify-account-deleted)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (supervisor-username ?u) (password-for spotify ?pw)
                       (not (spotify-account-deleted)) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (song-library-listed))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (album-library-listed))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (playlist-library-listed))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?ar - artist)
    :precondition (and (not (task-completed)) (song-library-listed)
                       (album-library-listed) (playlist-library-listed))
    :effect (and (found-title ?s) (artist-of ?ar ?s) (known-id ?ar)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist)
    :precondition (and (not (task-completed)) (known-id ?ar))
    :effect (found-artist-name ?ar))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (supervisor-username ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - file-path ?t - token ?c - content ?s - song ?ar - artist)
    :precondition (and (not (task-completed)) (has-token file-system ?t)
                       (backup-path ?p) (csv-of ?c ?s ?ar)
                       (found-title ?s) (artist-of ?ar ?s) (found-artist-name ?ar)
                       (not (backup-file-created)))
    :effect (backup-file-created))

  ; API: spotify.delete_account
  (:action spotify-delete-account
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (backup-file-created) (not (spotify-account-deleted)))
    :effect (and (spotify-account-deleted) (not (has-token spotify ?t))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (backup-file-created) (spotify-account-deleted) (not (task-completed)))
    :effect (task-completed))
)
