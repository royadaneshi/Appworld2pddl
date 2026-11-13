(define (problem task-652485c-2)
  (:domain appworld-652485c-2)
  (:objects
    richard-riddle - person
    ric-riddle-at-gmail-com phone-username-4436271690 - username
    spotify-password phone-password - password
    spotify-token phone-token - token
    my-song-library - song-library
    title-my-liked-songs - title
    is-public-true - privacy
    wife - relationship
    wife-phone-number - phone-number
    library-album-1 library-album-2 library-album-3 - album
    library-playlist-1 library-playlist-2 library-playlist-3 - playlist
    new-playlist-url library-playlist-url-1 library-playlist-url-2 library-playlist-url-3 - url
  )
  (:init
    (username-for spotify ric-riddle-at-gmail-com)
    (username-for phone phone-username-4436271690)
    (password-for spotify spotify-password)
    (password-for phone phone-password)
    (token-for spotify spotify-token)
    (token-for phone phone-token)
    (privacy-public is-public-true)
    (playlist-title new-playlist title-my-liked-songs)
    (message-contains-url playlist-url-message new-playlist-url)
    (has-relationship wife-contact wife)
    (contact-phone wife-contact wife-phone-number)
    (url-of new-playlist new-playlist-url)
    (url-of library-playlist-1 library-playlist-url-1)
    (url-of library-playlist-2 library-playlist-url-2)
    (url-of library-playlist-3 library-playlist-url-3)
    (in-album-library library-album-1)
    (in-album-library library-album-2)
    (in-album-library library-album-3)
    (in-playlist-library library-playlist-1)
    (in-playlist-library library-playlist-2)
    (in-playlist-library library-playlist-3)
    (song-in-source song-1 library-album-2)
    (song-in-source song-2 library-album-2)
    (song-in-source song-3 library-album-3)
    (song-in-source song-4 library-album-1)
    (song-in-source song-5 my-song-library)
    (song-in-source song-6 library-playlist-1)
    (song-in-source song-7 library-playlist-2)
    (song-in-source song-8 library-playlist-3)
    (song-in-source song-9 my-song-library)
    (song-in-source song-10 my-song-library)
    (song-in-source song-11 my-song-library)
    (liked song-1)
    (liked song-2)
    (liked song-3)
    (liked song-4)
    (liked song-5)
    (liked song-6)
    (liked song-7)
    (liked song-8)
    (liked song-9)
    (liked song-10)
    (liked song-11))
  (:goal (and
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
    (task-completed)))
)
