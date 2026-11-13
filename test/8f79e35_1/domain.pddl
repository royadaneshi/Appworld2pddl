(define (domain appworld-8f79e35-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token path draft email subject body - object
  )
  (:constants
    file-system gmail - app
    invitee-1 invitee-2 invitee-3 invitee-4 invitee-5 invitee-6 - person
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (in-directory ?f - path ?d - path)
    (file-read ?f - path)
    (invitee-in-file ?p - person ?f - path)
    (invitee-email ?p - person ?e - email)
    (template-read ?d - draft)
    (draft-subject ?d - draft ?s - subject)
    (body-for ?p - person ?b - body)
    (invitation-sent ?p - person)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - path ?f - path)
    :precondition (and (has-token file-system ?t) (in-directory ?f ?d) (not (task-completed)))
    :effect (and (known-id ?f))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token)
    :precondition (and (has-token file-system ?t) (known-id ?f) (not (task-completed)))
    :effect (and (file-read ?f))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?d - draft)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (and (known-id ?d))
  )

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (not (task-completed)))
    :effect (and (template-read ?d))
  )

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?p - person ?d - draft ?f - path)
    :precondition (and (has-token gmail ?t) (file-read ?f) (invitee-in-file ?p ?f) (invitee-email ?p ?e) (template-read ?d) (draft-subject ?d ?s) (body-for ?p ?b) (not (invitation-sent ?p)) (not (task-completed)))
    :effect (and (invitation-sent ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (invitation-sent invitee-1)
      (invitation-sent invitee-2)
      (invitation-sent invitee-3)
      (invitation-sent invitee-4)
      (invitation-sent invitee-5)
      (invitation-sent invitee-6)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
