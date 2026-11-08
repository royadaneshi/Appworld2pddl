(define (problem task-6f4b9a5-3)
  (:domain appworld-6f4b9a5-3)
  (:objects
    alex-white - person
    alexwhite-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-liked-songs query-song-3-title query-song-4-title query-song-5-title query-song-6-title - query
    liked-songs-note - note
    song-1 song-2 song-3 song-4 song-5 song-6 - song
    content-with-release-months - content
    count-0 count-1 count-2 count-3 count-4 - count)
  (:init
    (password-for simple-note simple-note-password)
    (note-query liked-songs-note query-liked-songs)
    (in-note song-1 liked-songs-note)
    (in-note song-2 liked-songs-note)
    (in-note song-3 liked-songs-note)
    (in-note song-4 liked-songs-note)
    (in-note song-5 liked-songs-note)
    (in-note song-6 liked-songs-note)
    (known-release-month song-1)
    (known-release-month song-2)
    (title-query song-3 query-song-3-title)
    (title-query song-4 query-song-4-title)
    (title-query song-5 query-song-5-title)
    (title-query song-6 query-song-6-title)
    (lookups-done count-0)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3)
    (next-count count-3 count-4)
    (missing-count liked-songs-note count-4)
    (new-content liked-songs-note content-with-release-months))
  (:goal (and (note-updated liked-songs-note content-with-release-months)
              (task-completed)))
)
