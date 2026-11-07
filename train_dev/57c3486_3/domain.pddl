(define (domain appworld-57c3486-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query count artist song - object)
  (:constants
    spotify - app
    count-0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (supervisor-email ?p - person ?u - username)
    (has-token ?a - app ?t - token)
    (follows ?ar - artist)
    (following-listed)
    (artist-name ?ar - artist ?q - query)
    (known-artist-name ?ar - artist ?q - query)
    (by-artist ?s - song ?ar - artist)
    (songs-found ?ar - artist)
    (liked ?s - song)
    (remaining ?n - count)
    (succ ?lower - count ?higher - count)
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
    :parameters (?u - username ?pw - password ?t - token ?p - person)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (supervisor-email ?p ?u)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t))
    :effect (and (following-listed)))

  ; API: spotify.show_artist
  (:action spotify-show-artist
    :parameters (?ar - artist ?q - query)
    :precondition (and (not (task-completed))
                       (following-listed)
                       (follows ?ar)
                       (artist-name ?ar ?q))
    :effect (and (known-artist-name ?ar ?q)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?ar - artist)
    :precondition (and (not (task-completed))
                       (known-artist-name ?ar ?q))
    :effect (and (songs-found ?ar)))

  ; API: spotify.like_song
  (:action spotify-like-song
    :parameters (?s - song ?t - token ?ar - artist ?n - count ?m - count)
    :precondition (and (not (task-completed))
                       (has-token spotify ?t)
                       (by-artist ?s ?ar)
                       (songs-found ?ar)
                       (not (liked ?s))
                       (remaining ?n)
                       (succ ?m ?n))
    :effect (and (liked ?s)
                 (not (remaining ?n))
                 (remaining ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (remaining count-0))
    :effect (and (task-completed)))
)
