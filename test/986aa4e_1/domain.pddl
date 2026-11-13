(define (domain appworld-986aa4e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query text boolean-value - object
    entity - object
    project task-item playlist song - entity)
  (:constants supervisor todoist spotify - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-for ?q - query ?x - entity)
    (task-in-project ?tk - task-item ?p - project)
    (playlist-for-task ?pl - playlist ?tk - task-item)
    (suggestions-known ?tk - task-item)
    (suggested-add ?tk - task-item ?s - song)
    (suggested-remove ?tk - task-item ?s - song)
    (playlist-songs-known ?pl - playlist)
    (in-playlist ?pl - playlist ?s - song)
    (comment-posted ?tk - task-item ?c - text)
    (task-marked-complete ?tk - task-item)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app todoist ?t) (credential-of-app todoist ?pw) (credential-of-app todoist ?u) (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)) (not (task-completed)))
    :effect (has-token todoist ?t))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token ?q - query ?p - project)
    :precondition (and (has-token todoist ?t) (query-for ?q ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?p - project ?t - token ?tk - task-item)
    :precondition (and (has-token todoist ?t) (known-id ?p) (task-in-project ?tk ?p) (not (task-completed)))
    :effect (known-id ?tk))

  ; API: todoist.show_task_comments
  (:action todoist-show-task-comments
    :parameters (?tk - task-item ?t - token)
    :precondition (and (has-token todoist ?t) (known-id ?tk) (not (task-completed)))
    :effect (suggestions-known ?tk))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (has-token spotify ?t))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist ?tk - task-item)
    :precondition (and (has-token spotify ?t) (known-id ?tk) (playlist-for-task ?pl ?tk) (not (task-completed)))
    :effect (known-id ?pl))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (not (task-completed)))
    :effect (playlist-songs-known ?pl))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?tk - task-item)
    :precondition (and (suggestions-known ?tk) (suggested-add ?tk ?s) (query-for ?q ?s) (not (task-completed)))
    :effect (known-id ?s))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (known-id ?s) (not (in-playlist ?pl ?s)) (not (task-completed)))
    :effect (in-playlist ?pl ?s))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?pl - playlist ?s - song ?t - token ?tk - task-item)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (playlist-songs-known ?pl) (in-playlist ?pl ?s) (suggestions-known ?tk) (suggested-remove ?tk ?s) (not (task-completed)))
    :effect (not (in-playlist ?pl ?s)))

  ; API: todoist.post_task_comment
  (:action todoist-post-task-comment
    :parameters (?tk - task-item ?c - text ?t - token)
    :precondition (and (has-token todoist ?t) (known-id ?tk) (not (comment-posted ?tk ?c)) (not (task-completed)))
    :effect (comment-posted ?tk ?c))

  ; API: todoist.update_task
  (:action todoist-update-task
    :parameters (?tk - task-item ?t - token ?done - boolean-value)
    :precondition (and (has-token todoist ?t) (known-id ?tk) (not (task-marked-complete ?tk)) (not (task-completed)))
    :effect (task-marked-complete ?tk))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tk - task-item ?c - text ?pl - playlist ?a1 - song ?a2 - song ?r1 - song ?r2 - song)
    :precondition (and
      (playlist-for-task ?pl ?tk)
      (suggested-add ?tk ?a1) (suggested-add ?tk ?a2) (not (= ?a1 ?a2))
      (suggested-remove ?tk ?r1) (suggested-remove ?tk ?r2) (not (= ?r1 ?r2))
      (in-playlist ?pl ?a1) (in-playlist ?pl ?a2)
      (not (in-playlist ?pl ?r1)) (not (in-playlist ?pl ?r2))
      (comment-posted ?tk ?c)
      (task-marked-complete ?tk)
      (not (task-completed)))
    :effect (task-completed))
)
