(define (domain appworld-a97e35d-2)
  (:requirements :strips :typing :negative-preconditions :equality :universal-preconditions)
  (:types
    app person username password token directory file thread email body content query datetime - object
    candidate - person
    attachment - file
  )
  (:constants supervisor file-system gmail - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (in-directory ?f - file ?d - directory)
    (directory-listed ?d - directory)
    (file-read ?f - file)
    (candidates-list ?f - file)
    (offer-letter-template ?f - file)
    (template-for ?f - file ?c - candidate)
    (selected ?c - candidate)
    (rejected ?c - candidate)
    (search-query ?q - query)
    (search-since ?dt - datetime)
    (applications-searched)
    (application-thread ?th - thread ?c - candidate)
    (email-in-thread ?e - email ?th - thread)
    (thread-read ?th - thread)
    (reply-body ?b - body ?c - candidate)
    (offer-letter-path ?f - attachment ?c - candidate)
    (offer-letter-content ?x - content ?c - candidate)
    (attachment-for ?att - attachment ?c - candidate)
    (attachment-ready ?att - attachment)
    (replied ?c - candidate)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for file-system ?pw) (token-of file-system ?t) (not (has-token file-system ?t)))
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (not (task-completed)) (has-token file-system ?t))
    :effect (directory-listed ?d)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token ?d - directory)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (in-directory ?f ?d) (directory-listed ?d))
    :effect (file-read ?f)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for gmail ?pw) (token-of gmail ?t) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?dt - datetime)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (search-query ?q) (search-since ?dt))
    :effect (applications-searched)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (applications-searched))
    :effect (thread-read ?th)
  )

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?p - attachment ?t - token ?x - content ?c - candidate ?tmpl - file ?list - file)
    :precondition (and (not (task-completed)) (has-token file-system ?t)
      (offer-letter-path ?p ?c) (offer-letter-content ?x ?c) (selected ?c)
      (offer-letter-template ?tmpl) (file-read ?tmpl)
      (candidates-list ?list) (file-read ?list)
      (not (attachment-ready ?p)))
    :effect (attachment-ready ?p)
  )

  ; API: gmail.reply_to_email
  (:action gmail-reply-to-email
    :parameters (?th - thread ?e - email ?b - body ?t - token ?att - attachment ?fst - token ?c - candidate ?tmpl - file ?list - file)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?fst)
      (application-thread ?th ?c) (email-in-thread ?e ?th) (thread-read ?th)
      (reply-body ?b ?c)
      (template-for ?tmpl ?c) (file-read ?tmpl)
      (candidates-list ?list) (file-read ?list)
      (attachment-for ?att ?c) (attachment-ready ?att)
      (not (replied ?c)))
    :effect (replied ?c)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?c - candidate) (replied ?c)) (not (task-completed)))
    :effect (and (task-completed))
  )

)
