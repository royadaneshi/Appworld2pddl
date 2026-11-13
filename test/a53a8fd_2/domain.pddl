(define (domain appworld-a53a8fd-2)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person username password token draft file-path substring flag datetime - object
  )
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (drafts-listed)
    (employer-draft ?d - draft)
    (resume-file ?f - file-path)
    (file-matches ?s - substring ?f - file-path)
    (known-path ?f - file-path)
    (resume-attached ?d - draft)
    (sent ?d - draft)
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
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?dt - datetime)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (and (drafts-listed))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?ft - token ?s - substring ?rec - flag ?f - file-path)
    :precondition (and (has-token file-system ?ft) (file-matches ?s ?f) (not (task-completed)))
    :effect (and (known-path ?f))
  )

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?ft - token ?t - token ?ow - flag)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (drafts-listed) (employer-draft ?d) (known-path ?f) (resume-file ?f) (not (sent ?d)) (not (task-completed)))
    :effect (and (resume-attached ?d))
  )

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (drafts-listed) (employer-draft ?d) (resume-attached ?d) (not (sent ?d)) (not (task-completed)))
    :effect (and (sent ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?d - draft) (sent ?d)) (not (task-completed)))
    :effect (and (task-completed)))

)
