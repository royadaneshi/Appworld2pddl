(define (problem task-287e338-2)
  (:domain appworld-287e338-2)
  (:objects
    supervisor - person
    timothy-whit-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    recommended-song - song
    least-recommended-artist - artist
    least-recommended-artist-name - artist-name)
  (:init
    (account-username spotify timothy-whit-at-gmail-com)
    (password-for spotify spotify-password)
    (recommended recommended-song)
    (artist-of recommended-song least-recommended-artist)
    (least-recommended least-recommended-artist)
    (name-of least-recommended-artist least-recommended-artist-name))
  (:goal (and (found-name least-recommended-artist least-recommended-artist-name) (task-completed))))
