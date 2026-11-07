(define (problem task-ce359b5-3)
  (:domain appworld-ce359b5-3)
  (:objects
    laura-mccoy - person
    la-mcco-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 - playlist
    library-song-2019 library-song-2023 playlist-song-2020 playlist-song-2022 - song)
  (:init
    (username-for spotify la-mcco-at-gmail-com)
    (password-for spotify spotify-password)
    (in-container song-library library-song-2019)
    (in-container song-library library-song-2023)
    (in-container playlist-1 playlist-song-2020)
    (in-container playlist-1 playlist-song-2022)
    (released-in-or-before-2021 library-song-2019)
    (released-in-or-before-2021 playlist-song-2020))
  (:goal (and
    (release-known library-song-2019)
    (release-known library-song-2023)
    (release-known playlist-song-2020)
    (release-known playlist-song-2022)
    (not (in-container song-library library-song-2019))
    (in-container song-library library-song-2023)
    (listed playlist-1)
    (not (in-container playlist-1 playlist-song-2020))
    (in-container playlist-1 playlist-song-2022)
    (task-completed)))
)
