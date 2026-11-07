(define (domain appworld-aa8502b-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token artist - object)
  (:constants
    spotify - app
    artist-no-liked-1 artist-no-liked-2 artist-with-liked-1 - artist)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (spotify-username ?u - username)
    (has-token ?a - app ?t - token)
    (known-following-artists)
    (known-liked-songs)
    (followed ?ar - artist)
    (has-liked-song ?ar - artist)
    (unfollowed ?ar - artist)
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
    :precondition (and (profile-known)
                       (spotify-username ?u)
                       (passwords-known)
                       (password-for spotify ?pw)
                       (not (has-token spotify ?t))
                       (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_following_artists
  (:action spotify-show-following-artists
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t)
                       (not (task-completed)))
    :effect (and (known-following-artists)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t)
                       (not (task-completed)))
    :effect (and (known-liked-songs)))

  ; API: spotify.unfollow_artist
  (:action spotify-unfollow-artist
    :parameters (?ar - artist ?t - token)
    :precondition (and (has-token spotify ?t)
                       (known-following-artists)
                       (known-liked-songs)
                       (followed ?ar)
                       (not (has-liked-song ?ar))
                       (not (unfollowed ?ar))
                       (not (task-completed)))
    :effect (and (not (followed ?ar))
                 (unfollowed ?ar)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (unfollowed artist-no-liked-1)
                       (unfollowed artist-no-liked-2)
                       (not (unfollowed artist-with-liked-1))
                       (followed artist-with-liked-1)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
