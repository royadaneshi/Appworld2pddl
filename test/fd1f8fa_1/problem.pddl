(define (problem task-fd1f8fa-1)
  (:domain appworld-fd1f8fa-1)
  (:objects
    cheryl-martinez - person
    cheweber-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    liked-queue-song-1 liked-queue-song-2 unliked-queue-song - song
    pos-1 pos-2 pos-3 - position
    count-1 count-2 - count)
  (:init
    (password-for spotify spotify-password)
    (liked liked-queue-song-1)
    (liked liked-queue-song-2)
    (in-queue liked-queue-song-1)
    (in-queue unliked-queue-song)
    (in-queue liked-queue-song-2)
    (at-position liked-queue-song-1 pos-1)
    (at-position unliked-queue-song pos-2)
    (at-position liked-queue-song-2 pos-3)
    (liked-in-queue count-2)
    (count-after-removal count-2 count-1)
    (count-after-removal count-1 count-0)
    (next-liked-to-remove count-2 liked-queue-song-2)
    (next-liked-to-remove count-1 liked-queue-song-1))
  (:goal (and (liked-in-queue count-0) (playing) (task-completed))))
