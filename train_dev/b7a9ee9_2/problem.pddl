(define (problem task-b7a9ee9-2)
  (:domain appworld-b7a9ee9-2)
  (:objects
    andrew-brow-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    playlist-1 playlist-2 - playlist
    song-1 song-2 song-3 - song
    artist-1 artist-2 artist-3 - artist
    pop - genre
    count-1 count-2 - count)
  (:init
    (supervisor-username andrew-brow-at-gmail-com)
    (password-for spotify spotify-password)
    (in-library playlist-1)
    (in-library playlist-2)
    (in-playlist song-1 playlist-1)
    (in-playlist song-2 playlist-1)
    (in-playlist song-3 playlist-2)
    (song-genre song-1 reggae)
    (song-genre song-2 pop)
    (song-genre song-3 reggae)
    (song-artist song-1 artist-1)
    (song-artist song-2 artist-2)
    (song-artist song-3 artist-3)
    (remaining-to-follow count-2)
    (count-pred count-2 count-1)
    (count-pred count-1 count-0))
  (:goal (and (following artist-1)
              (following artist-3)
              (remaining-to-follow count-0)
              (task-completed))))
