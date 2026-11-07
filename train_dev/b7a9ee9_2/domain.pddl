(define (domain appworld-b7a9ee9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app username password token playlist song artist genre count - object)
  (:constants spotify - app reggae - genre count-0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (in-library ?p - playlist)
    (in-playlist ?s - song ?p - playlist)
    (song-genre ?s - song ?g - genre)
    (song-artist ?s - song ?ar - artist)
    (library-shown)
    (playlist-shown ?p - playlist)
    (song-shown ?s - song)
    (following ?ar - artist)
    (count-pred ?c - count ?cprev - count)
    (remaining-to-follow ?c - count)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (supervisor-username ?u)
                       (passwords-known)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (library-shown))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?p - playlist ?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (library-shown)
                       (in-library ?p))
    :effect (playlist-shown ?p))

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?p - playlist)
    :precondition (and (not (task-completed))
                       (playlist-shown ?p)
                       (in-playlist ?s ?p))
    :effect (song-shown ?s))

  ; API: spotify.follow_artist
  (:action spotify-follow-artist
    :parameters (?ar - artist ?t - token ?s - song ?c - count ?cnext - count)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (song-shown ?s)
                       (song-artist ?s ?ar)
                       (song-genre ?s reggae)
                       (not (following ?ar))
                       (remaining-to-follow ?c)
                       (count-pred ?c ?cnext))
    :effect (and (following ?ar)
                 (not (remaining-to-follow ?c))
                 (remaining-to-follow ?cnext)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (remaining-to-follow count-0))
    :effect (task-completed))
)
