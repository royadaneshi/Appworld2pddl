(define (domain appworld-c901732-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query album song - object)
  (:constants spotify - app)
  (:predicates
    (supervisor ?p - person)
    (username-of ?p - person ?u - username)
    (known-username ?u - username)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (album-query ?q - query ?al - album)
    (known-album-id ?al - album)
    (in-album ?s - song ?al - album)
    (next-song ?al - album ?prev - song ?s - song)
    (checked-upto ?al - album ?s - song)
    (last-song ?al - album ?s - song)
    (play-count-known ?s - song)
    (most-played ?al - album ?s - song)
    (playing ?s - song)
    (playing-most-played-song)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?p - person ?u - username)
    :precondition (and (supervisor ?p) (username-of ?p ?u) (not (task-completed)))
    :effect (known-username ?u)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (known-username ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t)
  )

  ; API: spotify.search_albums
  (:action spotify-search-albums
    :parameters (?q - query ?al - album)
    :precondition (and (album-query ?q ?al) (not (task-completed)))
    :effect (known-album-id ?al)
  )

  ; API: spotify.show_song
  (:action spotify-show-song
    :parameters (?s - song ?al - album ?prev - song)
    :precondition (and (known-album-id ?al) (in-album ?s ?al) (next-song ?al ?prev ?s) (checked-upto ?al ?prev) (not (task-completed)))
    :effect (and (play-count-known ?s) (checked-upto ?al ?s) (not (checked-upto ?al ?prev)))
  )

  ; API: spotify.play_music
  (:action spotify-play-music
    :parameters (?t - token ?s - song ?al - album ?last - song)
    :precondition (and (has-token spotify ?t) (most-played ?al ?s) (play-count-known ?s) (last-song ?al ?last) (checked-upto ?al ?last) (not (task-completed)))
    :effect (and (playing ?s) (playing-most-played-song))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (playing-most-played-song) (not (task-completed)))
    :effect (task-completed)
  )
)
