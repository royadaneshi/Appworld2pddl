(define (domain appworld-bcb9696-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query substring flag file-path entity - object
    draft attachment - entity)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (known-path ?f - file-path)
    (query-for ?q - query ?d - draft)
    (substring-for ?s - substring ?f - file-path)
    (recipient-of ?d - draft ?p - person)
    (attached ?a - attachment ?d - draft)
    (wrong-attachment ?a - attachment ?d - draft)
    (correct-file ?f - file-path ?d - draft)
    (file-attached ?f - file-path ?d - draft)
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
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (query-for ?q ?d) (not (task-completed)))
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
    :precondition (and (has-token file-system ?t) (substring-for ?s ?f) (not (task-completed)))
    :effect (known-path ?f))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?ft - token ?t - token)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-id ?d) (known-path ?f) (not (sent ?d)) (not (task-completed)))
    :effect (file-attached ?f ?d))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token ?ft - token)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-id ?d) (not (sent ?d)) (not (task-completed)))
    :effect (sent ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?a - attachment ?f - file-path)
    :precondition (and (wrong-attachment ?a ?d) (correct-file ?f ?d) (sent ?d) (not (attached ?a ?d)) (file-attached ?f ?d) (not (task-completed)))
    :effect (task-completed))
)
