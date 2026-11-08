(define (domain appworld-bcb9696-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query substring flag record - object
    draft attachment file-path - record)
  (:constants
    supervisor gmail file-system - app
    headshot-draft - draft
    cv-attachment headshot-attachment - attachment)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - record)
    (draft-matches ?d - draft ?q - query)
    (file-matches ?f - file-path ?s - substring)
    (attachment-of-file ?a - attachment ?f - file-path)
    (attached ?a - attachment ?d - draft)
    (sent ?d - draft)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?d ?q) (not (task-completed)))
    :effect (known-id ?d))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token ?a - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?d) (attached ?a ?d) (not (task-completed)))
    :effect (known-id ?a))

  ; API: gmail.remove_attachment_from_draft
  (:action gmail-remove-attachment-from-draft
    :parameters (?d - draft ?a - attachment ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (known-id ?a) (attached ?a ?d) (not (sent ?d)) (not (task-completed)))
    :effect (not (attached ?a ?d)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?s - substring ?r - flag ?f - file-path)
    :precondition (and (has-token file-system ?t) (file-matches ?f ?s) (not (task-completed)))
    :effect (known-id ?f))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token ?a - attachment)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?d) (known-id ?f) (attachment-of-file ?a ?f) (not (attached ?a ?d)) (not (sent ?d)) (not (task-completed)))
    :effect (attached ?a ?d))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (not (sent ?d)) (not (task-completed)))
    :effect (sent ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (sent headshot-draft) (attached headshot-attachment headshot-draft) (not (attached cv-attachment headshot-draft)) (not (task-completed)))
    :effect (task-completed))
)
