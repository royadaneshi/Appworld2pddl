(define (problem task-986aa4e-2)
  (:domain appworld-986aa4e-2)
  (:objects
    anita-burch - person
    anita-burch-at-gmail-com - username
    todoist-password spotify-password - password
    todoist-token spotify-token - token
    query-edinburgh query-song-add-1 query-song-add-2 - query
    edinburgh-trip-project - project
    spotify-playlist-task - task-item
    edinburgh-playlist - playlist
    song-add-1 song-add-2 song-remove-1 song-remove-2 - song
    comment-done - comment-text
    is-completed-true - completion-flag)
  (:init
    (password-for todoist todoist-password)
    (password-for spotify spotify-password)
    (project-matches-query edinburgh-trip-project query-edinburgh)
    (task-in-project spotify-playlist-task edinburgh-trip-project)
    (playlist-task spotify-playlist-task)
    (suggested-add song-add-1)
    (suggested-add song-add-2)
    (suggested-remove song-remove-1)
    (suggested-remove song-remove-2)
    (song-query song-add-1 query-song-add-1)
    (song-query song-add-2 query-song-add-2)
    (in-playlist song-remove-1 edinburgh-playlist)
    (in-playlist song-remove-2 edinburgh-playlist))
  (:goal (and
    (in-playlist song-add-1 edinburgh-playlist)
    (in-playlist song-add-2 edinburgh-playlist)
    (not (in-playlist song-remove-1 edinburgh-playlist))
    (not (in-playlist song-remove-2 edinburgh-playlist))
    (comment-posted spotify-playlist-task comment-done)
    (task-marked-complete spotify-playlist-task)
    (task-completed)))
)
