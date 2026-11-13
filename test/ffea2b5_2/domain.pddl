(define (domain appworld-ffea2b5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query content file-path record - object
    note draft - record
  )
  (:constants supervisor simple-note file-system gmail - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - record)
    (note-matches ?q - query ?n - note)
    (content-of ?n - note ?c - content)
    (content-known ?c - content)
    (file-created ?f - file-path ?c - content)
    (file-exists ?f - file-path)
    (draft-matches ?q - query ?d - draft)
    (draft-replies-to ?d - draft ?p - person)
    (draft-verified ?d - draft)
    (draft-attached ?d - draft ?f - file-path)
    (draft-has-attachment ?d - draft)
    (email-sent ?d - draft)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?q ?n) (not (task-completed)))
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?c - content)
    :precondition (and (known-id ?n) (has-token simple-note ?t) (content-of ?n ?c) (not (task-completed)))
    :effect (and (content-known ?c))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?f - file-path ?t - token ?c - content)
    :precondition (and (has-token file-system ?t) (content-known ?c) (not (file-exists ?f)) (not (task-completed)))
    :effect (and (file-created ?f ?c) (file-exists ?f))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?q ?d) (not (task-completed)))
    :effect (and (known-id ?d))
  )

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token ?p - person)
    :precondition (and (known-id ?d) (has-token gmail ?t) (draft-replies-to ?d ?p) (not (task-completed)))
    :effect (and (draft-verified ?d))
  )

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?ft - token ?t - token)
    :precondition (and (known-id ?d) (draft-verified ?d) (file-exists ?f) (has-token file-system ?ft) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-attached ?d ?f) (draft-has-attachment ?d))
  )

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (known-id ?d) (has-token gmail ?t) (draft-has-attachment ?d) (not (email-sent ?d)) (not (task-completed)))
    :effect (and (email-sent ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?f - file-path ?c - content)
    :precondition (and (file-created ?f ?c) (draft-attached ?d ?f) (email-sent ?d) (not (task-completed)))
    :effect (and (task-completed))
  )
)
