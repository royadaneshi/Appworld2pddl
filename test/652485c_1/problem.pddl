(define (problem task-652485c-1)
  (:domain appworld-652485c-1)
  (:objects
    katherine-smith husband - person
    ka-ball-at-gmail-com username-7863159797 - username
    spotify-password phone-password - password
    spotify-token phone-token - token
    my-song-library - song-library
    title-my-liked-songs - title
    public-true - privacy
    relationship-husband - relationship
    husband-phone-number - phone-number
    message-with-playlist-url - message
    album-1 album-2 album-3 album-4 - album
    new-playlist - playlist
    liked-song-in-song-library-1 liked-song-in-song-library-2 liked-song-in-song-library-3 liked-song-in-song-library-4 liked-song-in-song-library-5 liked-song-in-song-library-6 liked-song-in-song-library-7 liked-song-in-song-library-8 liked-song-in-song-library-9 liked-song-in-song-library-10 liked-song-in-song-library-11 - song
  )
  (:init
    (username-for spotify ka-ball-at-gmail-com)
    (username-for phone username-7863159797)
    (password-for spotify spotify-password)
    (password-for phone phone-password)
    (token-for spotify spotify-token)
    (token-for phone phone-token)
    (public-flag public-true)
    (has-relationship husband relationship-husband)
    (phone-number-of husband husband-phone-number)
    (message-has-link message-with-playlist-url new-playlist)
    (in-album-library album-1)
    (in-album-library album-2)
    (in-album-library album-3)
    (in-album-library album-4)
    (contains album-1 liked-song-in-song-library-1)
    (contains album-1 liked-song-in-song-library-2)
    (contains album-3 liked-song-in-song-library-3)
    (contains my-song-library liked-song-in-song-library-4)
    (contains album-4 liked-song-in-song-library-5)
    (contains my-song-library liked-song-in-song-library-6)
    (contains album-2 liked-song-in-song-library-7)
    (contains my-song-library liked-song-in-song-library-8)
    (contains my-song-library liked-song-in-song-library-9)
    (contains my-song-library liked-song-in-song-library-10)
    (contains my-song-library liked-song-in-song-library-11)
    (liked liked-song-in-song-library-1)
    (liked liked-song-in-song-library-2)
    (liked liked-song-in-song-library-3)
    (liked liked-song-in-song-library-4)
    (liked liked-song-in-song-library-5)
    (liked liked-song-in-song-library-6)
    (liked liked-song-in-song-library-7)
    (liked liked-song-in-song-library-8)
    (liked liked-song-in-song-library-9)
    (liked liked-song-in-song-library-10)
    (liked liked-song-in-song-library-11))
  (:goal (and
    (playlist-created new-playlist)
    (playlist-public new-playlist)
    (song-added new-playlist liked-song-in-song-library-1)
    (song-added new-playlist liked-song-in-song-library-2)
    (song-added new-playlist liked-song-in-song-library-3)
    (song-added new-playlist liked-song-in-song-library-4)
    (song-added new-playlist liked-song-in-song-library-5)
    (song-added new-playlist liked-song-in-song-library-6)
    (song-added new-playlist liked-song-in-song-library-7)
    (song-added new-playlist liked-song-in-song-library-8)
    (song-added new-playlist liked-song-in-song-library-9)
    (song-added new-playlist liked-song-in-song-library-10)
    (song-added new-playlist liked-song-in-song-library-11)
    (link-shared new-playlist husband)
    (task-completed)))
)
