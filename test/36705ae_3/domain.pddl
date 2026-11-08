(define (domain appworld-36705ae-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query thread email attachment body path - object
    dir-path file-path - path)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    ; static mailbox / file structure (ids are unknown until looked up)
    (thread-matches ?q - query ?th - thread)
    (in-thread ?e - email ?th - thread)
    (sender ?e - email ?p - person)
    (request-email ?e - email)
    (bill-email ?e - email)
    (email-attachment ?e - email ?a - attachment)
    (bill-file ?a - attachment ?f - file-path)
    (next-bill-file ?p - path ?f - file-path)
    (last-bill-file ?d - dir-path ?f - file-path)
    (zip-of ?d - dir-path ?z - file-path)
    (reply-body ?b - body)
    ; knowledge and state predicates
    (inbox-searched ?q - query)
    (email-shown ?e - email)
    (exists-path ?p - path)
    (bills-zipped ?z - file-path)
    (replied ?e - email ?b - body ?z - file-path))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query)
    :precondition (and (has-token gmail ?t) (not (inbox-searched ?q)) (not (task-completed)))
    :effect (and (inbox-searched ?q)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?q - query ?e - email)
    :precondition (and (has-token gmail ?t) (inbox-searched ?q) (thread-matches ?q ?th) (in-thread ?e ?th) (not (email-shown ?e)) (not (task-completed)))
    :effect (and (email-shown ?e)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dir-path ?t - token)
    :precondition (and (has-token file-system ?t) (not (exists-path ?d)) (not (task-completed)))
    :effect (and (exists-path ?d)))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?a - attachment ?tf - token ?tg - token ?f - file-path ?e - email ?prev - path)
    :precondition (and (has-token file-system ?tf) (has-token gmail ?tg) (email-shown ?e) (bill-email ?e) (email-attachment ?e ?a) (bill-file ?a ?f) (next-bill-file ?prev ?f) (exists-path ?prev) (not (exists-path ?f)) (not (task-completed)))
    :effect (and (exists-path ?f)))

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - dir-path ?t - token ?z - file-path ?last - file-path)
    :precondition (and (has-token file-system ?t) (exists-path ?d) (zip-of ?d ?z) (last-bill-file ?d ?last) (exists-path ?last) (not (exists-path ?z)) (not (task-completed)))
    :effect (and (exists-path ?z) (bills-zipped ?z)))

  ; API: gmail.reply_to_email
  (:action gmail-reply-to-email
    :parameters (?th - thread ?e - email ?b - body ?tg - token ?z - file-path ?tf - token)
    :precondition (and (has-token gmail ?tg) (has-token file-system ?tf) (email-shown ?e) (in-thread ?e ?th) (request-email ?e) (reply-body ?b) (bills-zipped ?z) (not (replied ?e ?b ?z)) (not (task-completed)))
    :effect (and (replied ?e ?b ?z)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?e - email ?b - body ?z - file-path)
    :precondition (and (replied ?e ?b ?z) (not (task-completed)))
    :effect (and (task-completed))))
