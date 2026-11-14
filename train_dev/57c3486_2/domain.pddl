(define (domain appworld-57c3486-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token artist song query count - object)
  (:constants spotify - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (follows ?ar - artist)
    (following-listed)
    (artist-known ?ar - artist)
    (artist-name ?ar - artist ?q - query)
    (songs-listed ?ar - artist)
    (song-by ?s - song ?ar - artist)
    (liked ?s - song)
    (like-count ?c - count)
    (next-count ?c1 - count ?c2 - count)
    (target-like-count ?c - count)
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
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (following-listed)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist)
    :precondition (and (following-listed) (follows ?ar) (not (task-completed)))
    :effect (and (artist-known ?ar)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist)
    :precondition (and (artist-known ?ar) (artist-name ?ar ?q) (not (task-completed)))
    :effect (and (songs-listed ?ar)))

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token ?ar - artist ?c1 - count ?c2 - count)
    :precondition (and (has-token spotify ?t) (songs-listed ?ar) (song-by ?s ?ar) (not (liked ?s)) (like-count ?c1) (next-count ?c1 ?c2) (not (task-completed)))
    :effect (and (liked ?s) (not (like-count ?c1)) (like-count ?c2)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed))))
