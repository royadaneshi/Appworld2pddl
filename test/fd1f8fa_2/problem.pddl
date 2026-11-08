(define (problem task-fd1f8fa-2)
  (:domain appworld-fd1f8fa-2)
  (:objects
    erika-blackburn - person
    erikabail-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    no-song - song
    position-1 position-2 position-3 position-4 - position)
  (:init
    (password-for spotify spotify-password)
    (in-queue queue-song-1)
    (in-queue queue-song-2)
    (in-queue queue-song-3)
    (in-queue queue-song-4)
    (at-position queue-song-1 position-1)
    (at-position queue-song-2 position-2)
    (at-position queue-song-3 position-3)
    (at-position queue-song-4 position-4)
    (liked queue-song-1)
    (liked queue-song-3)
    (later-unliked queue-song-4 no-song)
    (later-unliked queue-song-2 queue-song-4))
  (:goal (and (in-queue queue-song-1)
              (not (in-queue queue-song-2))
              (in-queue queue-song-3)
              (not (in-queue queue-song-4))
              (player-playing)
              (task-completed)))
)
