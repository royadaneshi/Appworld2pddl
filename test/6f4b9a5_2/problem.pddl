(define (problem task-6f4b9a5-2)
  (:domain appworld-6f4b9a5-2)
  (:objects
    cesar - person
    ce-maldonado-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-liked-songs - query
    note-liked-songs - note
    content-with-release-months - content
  )
  (:init
    (username-for simple-note ce-maldonado-at-gmail-com)
    (username-for spotify ce-maldonado-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (note-matches query-liked-songs note-liked-songs)
    (content-completes content-with-release-months note-liked-songs)
  )
  (:goal (and
    (note-updated note-liked-songs content-with-release-months)
    (task-completed)
  ))
)
