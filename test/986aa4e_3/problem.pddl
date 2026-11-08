(define (problem task-986aa4e-3)
  (:domain appworld-986aa4e-3)
  (:objects
    jamie - person
    jamie-solomon-at-gmail-com - username
    todoist-password spotify-password - password
    todoist-token spotify-token - token
    query-bangkok query-song-add-1 query-song-add-2 - query
    bangkok-trip-project - project
    spotify-playlist-task - task-item
    bangkok-playlist - playlist
    song-add-1 song-add-2 song-remove-1 song-remove-2 - song
    comment-thanks-updated - comment-text
    flag-true - flag)
  (:init
    (username-for todoist jamie-solomon-at-gmail-com)
    (username-for spotify jamie-solomon-at-gmail-com)
    (password-for todoist todoist-password)
    (password-for spotify spotify-password)
    (project-query query-bangkok bangkok-trip-project)
    (task-in-project spotify-playlist-task bangkok-trip-project)
    (playlist-query query-bangkok bangkok-playlist)
    (song-query query-song-add-1 song-add-1)
    (song-query query-song-add-2 song-add-2)
    (suggested-add song-add-1)
    (suggested-add song-add-2)
    (suggested-remove song-remove-1)
    (suggested-remove song-remove-2)
    (in-playlist bangkok-playlist song-remove-1)
    (in-playlist bangkok-playlist song-remove-2))
  (:goal (and
    (in-playlist bangkok-playlist song-add-1)
    (in-playlist bangkok-playlist song-add-2)
    (not (in-playlist bangkok-playlist song-remove-1))
    (not (in-playlist bangkok-playlist song-remove-2))
    (comment-posted spotify-playlist-task comment-thanks-updated)
    (task-marked-complete spotify-playlist-task)
    (task-completed)))
)
