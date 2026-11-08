(define (problem task-d194965-2)
  (:domain appworld-d194965-2)
  (:objects
    kiara - person
    kia-bailey-at-gmail-com - username
    simple-note-password spotify-password - password
    simple-note-token spotify-token - token
    query-songs query-song-1 query-song-2 query-song-3 - query
    songs-note - note
    song-1 song-2 song-3 - song
    new-playlist - playlist
    songs-from-simple-note - title
    count-1 count-2 count-3 - count)
  (:init
    (password-for simple-note simple-note-password)
    (password-for spotify spotify-password)
    (note-matches-query songs-note query-songs)
    (song-in-note song-1 songs-note)
    (song-in-note song-2 songs-note)
    (song-in-note song-3 songs-note)
    (query-for-song query-song-1 song-1)
    (query-for-song query-song-2 song-2)
    (query-for-song query-song-3 song-3)
    (next-count count-0 count-1)
    (next-count count-1 count-2)
    (next-count count-2 count-3)
    (note-song-count songs-note count-3))
  (:goal (and
    (playlist-created new-playlist)
    (playlist-title new-playlist songs-from-simple-note)
    (song-in-playlist song-1 new-playlist)
    (song-in-playlist song-2 new-playlist)
    (song-in-playlist song-3 new-playlist)
    (playlist-song-count new-playlist count-3)
    (task-completed)))
)
