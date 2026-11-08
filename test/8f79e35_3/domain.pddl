(define (domain appworld-8f79e35-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email subject body record - object
    path draft - record)
  (:constants
    supervisor file-system gmail - app
    invitee-1 invitee-2 invitee-3 - person)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (in-directory ?f - path ?dir - path)
    (known-id ?x - record)
    (file-read ?f - path)
    (listed-in ?p - person ?f - path)
    (email-of ?p - person ?e - email)
    (draft-matches ?d - draft ?q - query)
    (template-read ?d - draft)
    (draft-subject ?d - draft ?s - subject)
    (personalized-body ?d - draft ?p - person ?b - body)
    (invited ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?dir - path ?f - path)
    :precondition (and (has-token file-system ?t) (in-directory ?f ?dir) (not (task-completed)))
    :effect (known-id ?f))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token)
    :precondition (and (known-id ?f) (has-token file-system ?t) (not (task-completed)))
    :effect (file-read ?f))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?d ?q) (not (task-completed)))
    :effect (known-id ?d))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (known-id ?d) (has-token gmail ?t) (not (task-completed)))
    :effect (template-read ?d))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?p - person ?d - draft ?f - path)
    :precondition (and (has-token gmail ?t) (file-read ?f) (listed-in ?p ?f) (email-of ?p ?e) (template-read ?d) (draft-subject ?d ?s) (personalized-body ?d ?p ?b) (not (invited ?p)) (not (task-completed)))
    :effect (invited ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (invited invitee-1) (invited invitee-2) (invited invitee-3) (not (task-completed)))
    :effect (task-completed)))
