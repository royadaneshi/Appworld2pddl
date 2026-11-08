(define (domain appworld-ffea2b5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query content file-path entity - object
    note email-thread draft - entity)
  (:constants supervisor gmail simple-note file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (note-matches-query ?n - note ?q - query)
    (note-content ?n - note ?c - content)
    (found-content ?c - content)
    (file-created ?f - file-path)
    (file-has-content ?f - file-path ?c - content)
    (thread-matches-query ?th - email-thread ?q - query)
    (draft-in-thread ?d - draft ?th - email-thread)
    (attached ?d - draft ?c - content)
    (sent ?d - draft)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action simple-note-login
    ; API: simple_note.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  (:action simple-note-search-notes
    ; API: simple_note.search_notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches-query ?n ?q) (not (task-completed)))
    :effect (known-id ?n))

  (:action simple-note-show-note
    ; API: simple_note.show_note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (note-content ?n ?c) (not (task-completed)))
    :effect (found-content ?c))

  (:action file-system-login
    ; API: file_system.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  (:action file-system-create-file
    ; API: file_system.create_file
    :parameters (?f - file-path ?t - token ?c - content)
    :precondition (and (has-token file-system ?t) (found-content ?c) (not (file-created ?f)) (not (task-completed)))
    :effect (and (file-created ?f) (file-has-content ?f ?c)))

  (:action gmail-login
    ; API: gmail.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  (:action gmail-show-inbox-threads
    ; API: gmail.show_inbox_threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches-query ?th ?q) (not (task-completed)))
    :effect (known-id ?th))

  (:action gmail-show-thread
    ; API: gmail.show_thread
    :parameters (?th - email-thread ?t - token ?d - draft)
    :precondition (and (has-token gmail ?t) (known-id ?th) (draft-in-thread ?d ?th) (not (task-completed)))
    :effect (known-id ?d))

  (:action gmail-upload-attachments-to-draft
    ; API: gmail.upload_attachments_to_draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token ?c - content)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?d) (file-created ?f) (file-has-content ?f ?c) (not (sent ?d)) (not (task-completed)))
    :effect (attached ?d ?c))

  (:action gmail-send-email-from-draft
    ; API: gmail.send_email_from_draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (not (sent ?d)) (not (task-completed)))
    :effect (sent ?d))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?d - draft ?c - content)
    :precondition (and (sent ?d) (attached ?d ?c) (not (task-completed)))
    :effect (task-completed))
)
