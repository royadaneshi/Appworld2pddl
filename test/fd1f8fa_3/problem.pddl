(define (problem task-fd1f8fa-3)
  (:domain appworld-fd1f8fa-3)
  (:objects
    matthew-blac-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-song-1 liked-song-2 unliked-song-1 unliked-song-2 unliked-song-3 - song
    pos-1 pos-2 pos-3 pos-4 pos-5 - position)
  (:init
    (password-for spotify spotify-password)
    (in-queue unliked-song-1) (at-position unliked-song-1 pos-1)
    (in-queue liked-song-2) (at-position liked-song-2 pos-2)
    (in-queue unliked-song-2) (at-position unliked-song-2 pos-3)
    (in-queue liked-song-1) (at-position liked-song-1 pos-4)
    (in-queue unliked-song-3) (at-position unliked-song-3 pos-5)
    (liked liked-song-1)
    (liked liked-song-2)
    (next-liked-removal pos-4)
    (next-liked-below pos-4 pos-2)
    (next-liked-below pos-2 pos-none))
  (:goal (and (next-liked-removal pos-none) (playing) (task-completed))))
