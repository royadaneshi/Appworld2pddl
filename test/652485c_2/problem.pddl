(define (problem task-652485c-2)
  (:domain appworld-652485c-2)
  (:objects
    richard-riddle - person
    ric-riddle-at-gmail-com phone-username-4436271690 - username
    spotify-password phone-password - password
    spotify-token phone-token - token
    my-song-library - song-library
    library-album-1 - album
    library-playlist-1 - playlist
    song-d - song
    new-playlist-url library-playlist-1-url - url
    title-my-liked-songs - title
    is-public-true - privacy
    wife - relationship
    wife-phone-number - phone-number)
  (:init
    (username-for spotify ric-riddle-at-gmail-com)
    (username-for phone phone-username-4436271690)
    (password-for spotify spotify-password)
    (password-for phone phone-password)
    (token-for spotify spotify-token)
    (token-for phone phone-token)
    (in-album-library library-album-1)
    (in-playlist-library library-playlist-1)
    (song-in-source song-a my-song-library)
    (song-in-source song-d my-song-library)
    (song-in-source song-b library-album-1)
    (song-in-source song-c library-playlist-1)
    (liked song-a)
    (liked song-b)
    (liked song-c)
    (privacy-public is-public-true)
    (playlist-title new-playlist title-my-liked-songs)
    (url-of new-playlist new-playlist-url)
    (url-of library-playlist-1 library-playlist-1-url)
    (message-contains-url playlist-url-message new-playlist-url)
    (has-relationship wife-contact wife)
    (contact-phone wife-contact wife-phone-number))
  (:goal (and
    (playlist-created new-playlist)
    (playlist-public new-playlist)
    (added-to-playlist new-playlist song-a)
    (added-to-playlist new-playlist song-b)
    (added-to-playlist new-playlist song-c)
    (text-sent wife-contact playlist-url-message)
    (task-completed)))
)
