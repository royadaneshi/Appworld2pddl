(define (domain appworld-a97e35d-1)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person username password token path content body query datetime thread email - object
    candidate - person
    directory selection-list acceptance-template rejection-template offer-template attachment - path
    offer-letter - attachment
  )
  (:constants file-system gmail - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for-app ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (recruiting-directory ?d - directory)
    (in-directory ?p - path ?d - directory)
    (directory-listed ?d - directory)
    (file-read ?p - path)
    (selected ?c - candidate)
    (offer-content-for ?k - content ?c - candidate)
    (attachment-for ?att - attachment ?c - candidate)
    (attachment-ready ?att - attachment)
    (body-for ?b - body ?c - candidate)
    (body-from-template ?b - body ?tpl - path)
    (position-query ?q - query)
    (cutoff-datetime ?dt - datetime)
    (applications-searched)
    (application-email ?c - candidate ?e - email ?th - thread)
    (replied ?c - candidate)
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
    :precondition (and (passwords-known) (password-for file-system ?pw) (token-for-app file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (recruiting-directory ?d) (not (directory-listed ?d)) (not (task-completed)))
    :effect (and (directory-listed ?d))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?p - path ?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (directory-listed ?d) (in-directory ?p ?d) (not (file-read ?p)) (not (task-completed)))
    :effect (and (file-read ?p))
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - offer-letter ?t - token ?k - content ?c - candidate ?tpl - offer-template ?sel - selection-list)
    :precondition (and (has-token file-system ?t) (file-read ?tpl) (file-read ?sel) (selected ?c) (attachment-for ?p ?c) (offer-content-for ?k ?c) (not (attachment-ready ?p)) (not (task-completed)))
    :effect (and (attachment-ready ?p))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (token-for-app gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?dt - datetime)
    :precondition (and (has-token gmail ?t) (position-query ?q) (cutoff-datetime ?dt) (not (applications-searched)) (not (task-completed)))
    :effect (and (applications-searched))
  )

  ; API: gmail.reply_to_email
  (:action gmail-reply-to-email
    :parameters (?th - thread ?e - email ?b - body ?t - token ?att - attachment ?ft - token ?c - candidate ?tpl - path ?sel - selection-list)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (applications-searched) (application-email ?c ?e ?th) (file-read ?sel) (body-for ?b ?c) (body-from-template ?b ?tpl) (file-read ?tpl) (attachment-for ?att ?c) (attachment-ready ?att) (not (replied ?c)) (not (task-completed)))
    :effect (and (replied ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?c - candidate) (replied ?c)) (not (task-completed)))
    :effect (and (task-completed))
  )

)
