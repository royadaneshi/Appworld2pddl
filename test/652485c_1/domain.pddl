(define (domain appworld-652485c-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token - object
    collection song title privacy relationship phone-number message - object
    song-library album playlist - collection)
  (:constants spotify phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-album-library ?al - album)
    (in-playlist-library ?pl - playlist)
    (album-library-shown)
    (playlist-library-shown)
    (collection-shown ?c - collection)
    (contains ?c - collection ?s - song)
    (liked ?s - song)
    (liked-songs-shown)
    (public-flag ?pub - privacy)
    (playlist-created ?pl - playlist)
    (playlist-public ?pl - playlist)
    (song-added ?pl - playlist ?s - song)
    (link-known ?pl - playlist)
    (has-relationship ?p - person ?rel - relationship)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-has-link ?msg - message ?pl - playlist)
    (link-shared ?pl - playlist ?p - person))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  (:action spotify-login
    ; API: spotify.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for spotify ?u) (password-for spotify ?pw)
                       (token-for spotify ?t) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  (:action spotify-show-song-library
    ; API: spotify.show_song_library
    :parameters (?t - token ?lib - song-library)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (collection-shown ?lib))

  (:action spotify-show-album-library
    ; API: spotify.show_album_library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (album-library-shown))

  (:action spotify-show-album
    ; API: spotify.show_album
    :parameters (?al - album)
    :precondition (and (not (task-completed)) (album-library-shown) (in-album-library ?al))
    :effect (collection-shown ?al))

  (:action spotify-show-playlist-library
    ; API: spotify.show_playlist_library
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (playlist-library-shown))

  (:action spotify-show-playlist
    ; API: spotify.show_playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (playlist-library-shown) (in-playlist-library ?pl))
    :effect (and (collection-shown ?pl) (link-known ?pl)))

  (:action spotify-show-liked-songs
    ; API: spotify.show_liked_songs
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t))
    :effect (liked-songs-shown))

  (:action spotify-create-playlist
    ; API: spotify.create_playlist
    :parameters (?title - title ?t - token ?pub - privacy ?pl - playlist)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (public-flag ?pub)
                       (not (in-playlist-library ?pl)) (not (playlist-created ?pl)))
    :effect (and (playlist-created ?pl) (playlist-public ?pl) (in-playlist-library ?pl)))

  (:action spotify-add-song-to-playlist
    ; API: spotify.add_song_to_playlist
    :parameters (?pl - playlist ?s - song ?t - token ?c - collection)
    :precondition (and (not (task-completed)) (has-token spotify ?t)
                       (playlist-created ?pl)
                       (contains ?c ?s) (collection-shown ?c)
                       (liked ?s) (liked-songs-shown)
                       (not (song-added ?pl ?s)))
    :effect (song-added ?pl ?s))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?rel - relationship ?p - person ?n - phone-number)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (has-relationship ?p ?rel) (phone-number-of ?p ?n))
    :effect (known-phone-number ?p ?n))

  (:action phone-send-text-message
    ; API: phone.send_text_message
    :parameters (?n - phone-number ?msg - message ?t - token ?p - person ?pl - playlist)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (known-phone-number ?p ?n)
                       (playlist-created ?pl) (link-known ?pl)
                       (message-has-link ?msg ?pl)
                       (not (link-shared ?pl ?p)))
    :effect (link-shared ?pl ?p))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?pl - playlist ?p - person ?s1 - song ?s2 - song ?s3 - song)
    :precondition (and (not (task-completed))
                       (playlist-created ?pl) (playlist-public ?pl)
                       (song-added ?pl ?s1) (song-added ?pl ?s2) (song-added ?pl ?s3)
                       (not (= ?s1 ?s2)) (not (= ?s1 ?s3)) (not (= ?s2 ?s3))
                       (link-shared ?pl ?p))
    :effect (task-completed))
)
