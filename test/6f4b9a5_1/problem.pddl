(define (problem task-6f4b9a5-1)
  (:domain appworld-6f4b9a5-1)
  (:objects
    laura - person
    la-mcco-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-liked-songs - query
    liked-songs-note - note
    content-with-release-months - content)
  (:init
    (username-for simple-note la-mcco-at-gmail-com)
    (username-for spotify la-mcco-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (new-content-for liked-songs-note content-with-release-months))
  (:goal (and
    (note-updated liked-songs-note content-with-release-months)
    (task-completed))))
