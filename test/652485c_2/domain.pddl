(define (domain appworld-652485c-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token phone-number message relationship title privacy url song source - object
    song-library album playlist - source)
  (:constants
    spotify phone supervisor - app
    new-playlist - playlist
    song-1 song-2 song-3 song-4 song-5 song-6 song-7 song-8 song-9 song-10 song-11 - song
    wife-contact - person
    playlist-url-message - message
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-album-library ?al - album)
    (in-playlist-library ?pl - playlist)
    (known-id ?src - source)
    (source-songs-known ?src - source)
    (song-in-source ?s - song ?src - source)
    (liked ?s - song)
    (liked-songs-known)
    (privacy-public ?pub - privacy)
    (playlist-title ?pl - playlist ?ti - title)
    (playlist-created ?pl - playlist)
    (playlist-public ?pl - playlist)
    (added-to-playlist ?pl - playlist ?s - song)
    (url-of ?pl - playlist ?u - url)
    (found-url ?u - url)
    (message-contains-url ?m - message ?u - url)
    (has-relationship ?p - person ?r - relationship)
    (contact-phone ?p - person ?pn - phone-number)
    (known-phone ?p - person ?pn - phone-number)
    (text-sent ?p - person ?m - message))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for spotify ?u) (password-for spotify ?pw) (token-for spotify ?t) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_song_library
  (:action spotify-show-song-library
    :parameters (?t - token ?lib - song-library)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (source-songs-known ?lib))

  ; API: spotify.show_album_library
  (:action spotify-show-album-library
    :parameters (?t - token ?al - album)
    :precondition (and (has-token spotify ?t) (in-album-library ?al) (not (task-completed)))
    :effect (known-id ?al))

  ; API: spotify.show_album
  (:action spotify-show-album
    :parameters (?al - album)
    :precondition (and (known-id ?al) (in-album-library ?al) (not (task-completed)))
    :effect (source-songs-known ?al))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (in-playlist-library ?pl) (not (task-completed)))
    :effect (known-id ?pl))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token ?u - url)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (url-of ?pl ?u) (not (task-completed)))
    :effect (and (source-songs-known ?pl) (found-url ?u)))

  ; API: spotify.show_liked_songs
  (:action spotify-show-liked-songs
    :parameters (?t - token)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (liked-songs-known))

  ; API: spotify.create_playlist
  (:action spotify-create-playlist
    :parameters (?ti - title ?t - token ?pub - privacy ?pl - playlist)
    :precondition (and (has-token spotify ?t) (privacy-public ?pub) (playlist-title ?pl ?ti) (not (in-playlist-library ?pl)) (not (playlist-created ?pl)) (not (task-completed)))
    :effect (and (playlist-created ?pl) (playlist-public ?pl) (known-id ?pl)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?src - source)
    :precondition (and (has-token spotify ?t) (playlist-created ?pl) (liked-songs-known) (liked ?s) (song-in-source ?s ?src) (source-songs-known ?src) (not (added-to-playlist ?pl ?s)) (not (task-completed)))
    :effect (added-to-playlist ?pl ?s))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?p - person ?pn - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?rel) (contact-phone ?p ?pn) (not (task-completed)))
    :effect (known-phone ?p ?pn))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?pn - phone-number ?msg - message ?t - token ?p - person ?u - url ?pl - playlist)
    :precondition (and (has-token phone ?t) (known-phone ?p ?pn) (message-contains-url ?msg ?u) (url-of ?pl ?u) (found-url ?u) (playlist-created ?pl) (not (task-completed)))
    :effect (text-sent ?p ?msg))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (playlist-created new-playlist)
      (playlist-public new-playlist)
      (added-to-playlist new-playlist song-1)
      (added-to-playlist new-playlist song-2)
      (added-to-playlist new-playlist song-3)
      (added-to-playlist new-playlist song-4)
      (added-to-playlist new-playlist song-5)
      (added-to-playlist new-playlist song-6)
      (added-to-playlist new-playlist song-7)
      (added-to-playlist new-playlist song-8)
      (added-to-playlist new-playlist song-9)
      (added-to-playlist new-playlist song-10)
      (added-to-playlist new-playlist song-11)
      (text-sent wife-contact playlist-url-message)
      (not (task-completed)))
    :effect (task-completed))
)
