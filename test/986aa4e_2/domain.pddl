(define (domain appworld-986aa4e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query comment-text completion-flag - object
    entity - object
    project task-item playlist song - entity)
  (:constants supervisor todoist spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (project-matches-query ?p - project ?q - query)
    (task-in-project ?k - task-item ?p - project)
    (playlist-task ?k - task-item)
    (suggestions-known)
    (suggested-add ?s - song)
    (suggested-remove ?s - song)
    (song-query ?s - song ?q - query)
    (playlist-songs-known ?pl - playlist)
    (in-playlist ?s - song ?pl - playlist)
    (comment-posted ?k - task-item ?c - comment-text)
    (task-marked-complete ?k - task-item)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: todoist.login
  (:action todoist-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for todoist ?pw) (not (has-token todoist ?t)) (not (task-completed)))
    :effect (and (has-token todoist ?t)))

  ; API: todoist.show_projects
  (:action todoist-show-projects
    :parameters (?t - token ?q - query ?p - project)
    :precondition (and (has-token todoist ?t) (project-matches-query ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: todoist.show_tasks
  (:action todoist-show-tasks
    :parameters (?p - project ?t - token ?k - task-item)
    :precondition (and (has-token todoist ?t) (known-id ?p) (task-in-project ?k ?p) (not (task-completed)))
    :effect (and (known-id ?k)))

  ; API: todoist.show_task_comments
  (:action todoist-show-task-comments
    :parameters (?k - task-item ?t - token)
    :precondition (and (has-token todoist ?t) (known-id ?k) (playlist-task ?k) (not (task-completed)))
    :effect (and (suggestions-known)))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for spotify ?pw) (not (has-token spotify ?t)) (not (task-completed)))
    :effect (and (has-token spotify ?t)))

  ; API: spotify.show_playlist_library
  (:action spotify-show-playlist-library
    :parameters (?t - token ?pl - playlist)
    :precondition (and (has-token spotify ?t) (not (task-completed)))
    :effect (and (known-id ?pl)))

  ; API: spotify.show_playlist
  (:action spotify-show-playlist
    :parameters (?pl - playlist ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (not (task-completed)))
    :effect (and (playlist-songs-known ?pl)))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song)
    :precondition (and (suggestions-known) (suggested-add ?s) (song-query ?s ?q) (not (task-completed)))
    :effect (and (known-id ?s)))

  ; API: spotify.add_song_to_playlist
  (:action spotify-add-song-to-playlist
    :parameters (?pl - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (known-id ?s) (suggested-add ?s) (not (in-playlist ?s ?pl)) (not (task-completed)))
    :effect (and (in-playlist ?s ?pl)))

  ; API: spotify.remove_song_from_playlist
  (:action spotify-remove-song-from-playlist
    :parameters (?pl - playlist ?s - song ?t - token)
    :precondition (and (has-token spotify ?t) (known-id ?pl) (playlist-songs-known ?pl) (suggestions-known) (suggested-remove ?s) (in-playlist ?s ?pl) (not (task-completed)))
    :effect (and (not (in-playlist ?s ?pl))))

  ; API: todoist.post_task_comment
  (:action todoist-post-task-comment
    :parameters (?k - task-item ?c - comment-text ?t - token)
    :precondition (and (has-token todoist ?t) (known-id ?k) (not (comment-posted ?k ?c)) (not (task-completed)))
    :effect (and (comment-posted ?k ?c)))

  ; API: todoist.update_task
  (:action todoist-update-task
    :parameters (?k - task-item ?t - token ?f - completion-flag)
    :precondition (and (has-token todoist ?t) (known-id ?k) (not (task-marked-complete ?k)) (not (task-completed)))
    :effect (and (task-marked-complete ?k)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?k - task-item ?c - comment-text ?pl - playlist ?a1 - song ?a2 - song ?r1 - song ?r2 - song)
    :precondition (and (comment-posted ?k ?c) (task-marked-complete ?k) (suggested-add ?a1) (suggested-add ?a2) (not (= ?a1 ?a2)) (in-playlist ?a1 ?pl) (in-playlist ?a2 ?pl) (suggested-remove ?r1) (suggested-remove ?r2) (not (= ?r1 ?r2)) (not (in-playlist ?r1 ?pl)) (not (in-playlist ?r2 ?pl)) (not (task-completed)))
    :effect (and (task-completed)))
)
