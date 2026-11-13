(define (problem task-986aa4e-1)
  (:domain appworld-986aa4e-1)
  (:objects
    jo-harr-at-gmail-com - username
    todoist-password spotify-password - password
    todoist-token spotify-token - token
    query-beijing query-song-to-add-1 query-song-to-add-2 query-song-to-add-3 query-song-to-add-4 query-song-to-add-5 - query
    beijing-trip-project - project
    spotify-playlist-task - task-item
    beijing-trip-playlist - playlist
    song-to-add-1 song-to-add-2 song-to-add-3 song-to-add-4 song-to-add-5 song-to-remove-1 song-to-remove-2 - song
    comment-incorporated-changes - text
    is-completed-true - boolean-value
  )
  (:init
    (credential-of-app todoist jo-harr-at-gmail-com)
    (credential-of-app todoist todoist-password)
    (credential-of-app todoist todoist-token)
    (credential-of-app spotify jo-harr-at-gmail-com)
    (credential-of-app spotify spotify-password)
    (credential-of-app spotify spotify-token)
    (password-for todoist todoist-password)
    (password-for spotify spotify-password)
    (query-for query-beijing beijing-trip-project)
    (task-in-project spotify-playlist-task beijing-trip-project)
    (playlist-for-task beijing-trip-playlist spotify-playlist-task)
    (suggested-add spotify-playlist-task song-to-add-1)
    (suggested-add spotify-playlist-task song-to-add-2)
    (suggested-add spotify-playlist-task song-to-add-3)
    (suggested-add spotify-playlist-task song-to-add-4)
    (suggested-add spotify-playlist-task song-to-add-5)
    (suggested-remove spotify-playlist-task song-to-remove-1)
    (suggested-remove spotify-playlist-task song-to-remove-2)
    (query-for query-song-to-add-1 song-to-add-1)
    (query-for query-song-to-add-2 song-to-add-2)
    (query-for query-song-to-add-3 song-to-add-3)
    (query-for query-song-to-add-4 song-to-add-4)
    (query-for query-song-to-add-5 song-to-add-5)
    (in-playlist beijing-trip-playlist song-to-remove-1)
    (in-playlist beijing-trip-playlist song-to-remove-2))
  (:goal (and
    (in-playlist beijing-trip-playlist song-to-add-1)
    (in-playlist beijing-trip-playlist song-to-add-2)
    (in-playlist beijing-trip-playlist song-to-add-3)
    (in-playlist beijing-trip-playlist song-to-add-4)
    (in-playlist beijing-trip-playlist song-to-add-5)
    (not (in-playlist beijing-trip-playlist song-to-remove-1))
    (not (in-playlist beijing-trip-playlist song-to-remove-2))
    (comment-posted spotify-playlist-task comment-incorporated-changes)
    (task-marked-complete spotify-playlist-task)
    (task-completed)))
)
