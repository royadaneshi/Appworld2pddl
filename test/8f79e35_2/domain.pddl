(define (domain appworld-8f79e35-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token path draft email subject body - object)
  (:constants file-system gmail supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (file-in-directory ?f - path ?d - path)
    (directory-listed ?d - path)
    (file-read ?f - path)
    (invitee-listed ?p - person ?f - path)
    (invitee-email ?p - person ?e - email)
    (drafts-listed)
    (template-draft ?dr - draft)
    (template-read ?dr - draft)
    (draft-subject ?dr - draft ?s - subject)
    (invite-body ?p - person ?b - body)
    (invitation-sent ?p - person))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - path)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (directory-listed ?d))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token ?d - path)
    :precondition (and (has-token file-system ?t) (directory-listed ?d) (file-in-directory ?f ?d) (not (task-completed)))
    :effect (file-read ?f))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (drafts-listed))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?dr - draft ?t - token)
    :precondition (and (has-token gmail ?t) (drafts-listed) (template-draft ?dr) (not (task-completed)))
    :effect (template-read ?dr))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?p - person ?f - path ?dr - draft)
    :precondition (and (has-token gmail ?t) (file-read ?f) (invitee-listed ?p ?f) (invitee-email ?p ?e) (template-draft ?dr) (template-read ?dr) (draft-subject ?dr ?s) (invite-body ?p ?b) (not (invitation-sent ?p)) (not (task-completed)))
    :effect (invitation-sent ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person)
    :precondition (and (invitation-sent ?p1) (invitation-sent ?p2) (invitation-sent ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (task-completed)))
