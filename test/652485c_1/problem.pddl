(define (problem task-652485c-1)
  (:domain appworld-652485c-1)
  (:objects
    katherine-smith husband - person
    ka-ball-at-gmail-com username-7863159797 - username
    spotify-password phone-password - password
    spotify-token phone-token - token
    my-song-library - song-library
    album-1 - album
    library-playlist-1 new-playlist - playlist
    liked-song-in-song-library liked-song-in-album-1 liked-song-in-playlist-1
    unliked-song-in-song-library liked-song-outside-libraries - song
    title-my-liked-songs - title
    public-true - privacy
    relationship-husband - relationship
    husband-phone-number - phone-number
    message-with-playlist-url - message)
  (:init
    (username-for spotify ka-ball-at-gmail-com)
    (username-for phone username-7863159797)
    (password-for spotify spotify-password)
    (password-for phone phone-password)
    (token-for spotify spotify-token)
    (token-for phone phone-token)
    (in-album-library album-1)
    (in-playlist-library library-playlist-1)
    (contains my-song-library liked-song-in-song-library)
    (contains my-song-library unliked-song-in-song-library)
    (contains album-1 liked-song-in-album-1)
    (contains library-playlist-1 liked-song-in-playlist-1)
    (liked liked-song-in-song-library)
    (liked liked-song-in-album-1)
    (liked liked-song-in-playlist-1)
    (liked liked-song-outside-libraries)
    (public-flag public-true)
    (has-relationship husband relationship-husband)
    (phone-number-of husband husband-phone-number)
    (message-has-link message-with-playlist-url new-playlist))
  (:goal (and
    (playlist-created new-playlist)
    (playlist-public new-playlist)
    (song-added new-playlist liked-song-in-song-library)
    (song-added new-playlist liked-song-in-album-1)
    (song-added new-playlist liked-song-in-playlist-1)
    (link-shared new-playlist husband)
    (task-completed)))
)
