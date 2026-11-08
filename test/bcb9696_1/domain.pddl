(define (domain appworld-bcb9696-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query path flag - object
    entity - object
    draft attachment file - entity
  )
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (draft-matches ?q - query ?d - draft)
    (draft-to ?d - draft ?p - person)
    (draft-exists ?d - draft)
    (attached-to-draft ?a - attachment ?d - draft)
    (removed-from-draft ?a - attachment ?d - draft)
    (file-matches ?q - query ?f - file)
    (file-at-path ?f - file ?p - path)
    (known-path ?f - file ?p - path)
    (file-attached-to-draft ?f - file ?d - draft)
    (draft-sent ?d - draft)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?q ?d) (draft-exists ?d) (not (task-completed)))
    :effect (and (known-id ?d))
  )

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token ?a - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?d) (draft-exists ?d) (attached-to-draft ?a ?d) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: gmail.remove_attachment_from_draft
  (:action gmail-remove-attachment-from-draft
    :parameters (?d - draft ?a - attachment ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (known-id ?a) (draft-exists ?d) (attached-to-draft ?a ?d) (not (task-completed)))
    :effect (and (not (attached-to-draft ?a ?d)) (removed-from-draft ?a ?d))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?r - flag ?f - file ?p - path)
    :precondition (and (has-token file-system ?t) (file-matches ?q ?f) (file-at-path ?f ?p) (not (task-completed)))
    :effect (and (known-path ?f ?p))
  )

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?p - path ?ft - token ?t - token ?f - file)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-id ?d) (draft-exists ?d) (known-path ?f ?p) (not (task-completed)))
    :effect (and (file-attached-to-draft ?f ?d))
  )

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (draft-exists ?d) (not (task-completed)))
    :effect (and (draft-sent ?d) (not (draft-exists ?d)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?a - attachment ?f - file)
    :precondition (and (removed-from-draft ?a ?d) (file-attached-to-draft ?f ?d) (draft-sent ?d) (not (task-completed)))
    :effect (and (task-completed))
  )
)
