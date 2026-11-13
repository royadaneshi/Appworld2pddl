(define (domain appworld-a53a8fd-3)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person username password token draft path query datetime flag - object)
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (window-start ?dt - datetime)
    (locates ?q - query ?p - path)
    (flag-is-true ?f - flag)
    (recent-employer-draft ?d - draft)
    (drafts-found)
    (known-path ?p - path)
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
    :precondition (and (passwords-known)
                       (username-for gmail ?u)
                       (password-for gmail ?pw)
                       (token-for gmail ?t)
                       (not (has-token gmail ?t))
                       (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for file-system ?u)
                       (password-for file-system ?pw)
                       (token-for file-system ?t)
                       (not (has-token file-system ?t))
                       (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?dt - datetime)
    :precondition (and (has-token gmail ?t)
                       (window-start ?dt)
                       (not (drafts-found))
                       (not (task-completed)))
    :effect (and (drafts-found)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?r - flag ?p - path)
    :precondition (and (has-token file-system ?t)
                       (flag-is-true ?r)
                       (locates ?q ?p)
                       (not (known-path ?p))
                       (not (task-completed)))
    :effect (and (known-path ?p)))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?p - path ?fst - token ?t - token ?ow - flag)
    :precondition (and (has-token gmail ?t)
                       (has-token file-system ?fst)
                       (drafts-found)
                       (recent-employer-draft ?d)
                       (known-path ?p)
                       (flag-is-true ?ow)
                       (not (resume-attached ?d))
                       (not (sent ?d))
                       (not (task-completed)))
    :effect (and (resume-attached ?d)))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t)
                       (resume-attached ?d)
                       (not (sent ?d))
                       (not (task-completed)))
    :effect (and (sent ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?d - draft) (sent ?d)) (not (task-completed)))
    :effect (and (task-completed)))

)
