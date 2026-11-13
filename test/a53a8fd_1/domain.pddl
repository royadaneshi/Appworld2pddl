(define (domain appworld-a53a8fd-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token draft file-path query datetime bool - object)
  (:constants
    gmail file-system supervisor - app
    draft-1 draft-2 draft-3 draft-4 draft-5 - draft
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (resume-file ?f - file-path)
    (known-path ?f - file-path)
    (drafts-listed)
    (employer-draft ?d - draft)
    (resume-attached ?d - draft)
    (sent ?d - draft)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?rec - bool ?f - file-path)
    :precondition (and (has-token file-system ?t) (resume-file ?f) (not (task-completed)))
    :effect (and (known-path ?f)))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?d - datetime)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (and (drafts-listed)))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?dr - draft ?f - file-path ?fst - token ?t - token ?ow - bool)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (drafts-listed) (employer-draft ?dr) (known-path ?f) (resume-file ?f) (not (sent ?dr)) (not (task-completed)))
    :effect (and (resume-attached ?dr)))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?dr - draft ?t - token)
    :precondition (and (has-token gmail ?t) (resume-attached ?dr) (not (sent ?dr)) (not (task-completed)))
    :effect (and (sent ?dr)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (sent draft-1)
      (sent draft-2)
      (sent draft-3)
      (sent draft-4)
      (sent draft-5)
      (not (task-completed)))
    :effect (and (task-completed))))
