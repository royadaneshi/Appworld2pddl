(define (domain appworld-6f4b9a5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note song content count - object)
  (:constants supervisor simple-note spotify - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (in-note ?s - song ?n - note)
    (title-query ?s - song ?q - query)
    (known-release-month ?s - song)
    (lookups-done ?k - count)
    (next-count ?k1 - count ?k2 - count)
    (missing-count ?n - note ?k - count)
    (new-content ?n - note ?c - content)
    (note-updated ?n - note ?c - content)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (note-query ?n ?q)
                       (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (known-id ?n)
                       (has-token simple-note ?t)
                       (not (task-completed)))
    :effect (note-read ?n))

  ; API: spotify.search_songs
  (:action spotify-search-songs
    :parameters (?q - query ?s - song ?n - note ?k1 - count ?k2 - count)
    :precondition (and (title-query ?s ?q)
                       (in-note ?s ?n)
                       (note-read ?n)
                       (not (known-release-month ?s))
                       (lookups-done ?k1)
                       (next-count ?k1 ?k2)
                       (not (task-completed)))
    :effect (and (known-release-month ?s)
                 (not (lookups-done ?k1))
                 (lookups-done ?k2)))

  ; API: simple_note.update_note
  (:action simple-note-update-note
    :parameters (?n - note ?t - token ?c - content ?k - count)
    :precondition (and (known-id ?n)
                       (note-read ?n)
                       (has-token simple-note ?t)
                       (new-content ?n ?c)
                       (lookups-done ?k)
                       (missing-count ?n ?k)
                       (not (note-updated ?n ?c))
                       (not (task-completed)))
    :effect (note-updated ?n ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?c - content)
    :precondition (and (note-updated ?n ?c)
                       (not (task-completed)))
    :effect (task-completed))
)
