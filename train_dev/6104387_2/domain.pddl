(define (domain appworld-6104387-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token song artist file-path file-content - object)
  (:constants spotify file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (profile-known)
    (passwords-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (listed-song-library)
    (listed-album-library)
    (listed-playlist-library)
    (song-artist ?s - song ?ar - artist)
    (known-song-details ?s - song)
    (known-artist-name ?ar - artist)
    (backup-target ?path - file-path ?content - file-content)
    (content-for-song ?content - file-content ?s - song)
    (file-created ?path - file-path)
    (backup-complete)
    (account-deleted ?a - app)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (profile-known) (passwords-known)
                       (supervisor-username ?u) (password-for spotify ?pw)
                       (not (has-token spotify ?t)) (not (account-deleted spotify))
                       (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (listed-song-library)))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (listed-album-library)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (listed-playlist-library)))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song)
    :precondition (and (listed-song-library) (listed-album-library) (listed-playlist-library)
                       (not (task-completed)))
    :effect (and (known-song-details ?s)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?s - song)
    :precondition (and (known-song-details ?s) (song-artist ?s ?ar) (not (task-completed)))
    :effect (and (known-artist-name ?ar)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (profile-known) (passwords-known)
                       (supervisor-username ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?path - file-path ?t - token ?content - file-content ?s - song ?ar - artist)
    :precondition (and (has-token file-system ?t) (backup-target ?path ?content)
                       (content-for-song ?content ?s) (song-artist ?s ?ar)
                       (known-song-details ?s) (known-artist-name ?ar)
                       (not (file-created ?path)) (not (task-completed)))
    :effect (and (file-created ?path) (backup-complete)))

  ; API: spotify.delete_account
  (:action spotify-delete-account
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (backup-complete) (not (task-completed)))
    :effect (and (account-deleted spotify) (not (has-token spotify ?t))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (backup-complete) (account-deleted spotify) (not (task-completed)))
    :effect (and (task-completed)))
)
