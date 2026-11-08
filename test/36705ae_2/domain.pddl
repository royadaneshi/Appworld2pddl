(define (domain appworld-36705ae-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread email attachment file-path directory-path body count - object
  )
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (thread-matches ?th - email-thread ?q - query)
    (email-in-thread ?e - email ?th - email-thread)
    (sent-by ?e - email ?p - person)
    (request-email ?e - email)
    (attachment-in-thread ?a - attachment ?th - email-thread)
    (attachment-target ?a - attachment ?f - file-path)
    (file-in-directory ?f - file-path ?d - directory-path)
    (archive-of ?d - directory-path ?f - file-path)
    (succ ?n1 - count ?n2 - count)
    (bill-count ?n - count)
    (searched ?q - query)
    (thread-read ?th - email-thread)
    (directory-exists ?d - directory-path)
    (downloaded ?f - file-path)
    (downloaded-count ?n - count)
    (tar-created ?f - file-path)
    (replied ?e - email ?b - body ?f - file-path)
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
    :precondition (and (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token gmail ?t))
    :effect (and (searched ?q))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (searched ?q) (thread-matches ?th ?q))
    :effect (and (thread-read ?th))
  )

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - directory-path ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (not (directory-exists ?d)))
    :effect (and (directory-exists ?d))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?a - attachment ?ft - token ?t - token ?f - file-path ?th - email-thread ?d - directory-path ?n1 - count ?n2 - count)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?ft) (thread-read ?th) (attachment-in-thread ?a ?th) (attachment-target ?a ?f) (file-in-directory ?f ?d) (directory-exists ?d) (not (downloaded ?f)) (downloaded-count ?n1) (succ ?n1 ?n2))
    :effect (and (downloaded ?f) (not (downloaded-count ?n1)) (downloaded-count ?n2))
  )

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory-path ?t - token ?tar - file-path ?n - count)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (directory-exists ?d) (archive-of ?d ?tar) (downloaded-count ?n) (bill-count ?n) (not (tar-created ?tar)))
    :effect (and (tar-created ?tar))
  )

  ; API: gmail.reply_to_email
  (:action gmail-reply-to-email
    :parameters (?th - email-thread ?e - email ?b - body ?t - token ?tar - file-path ?ft - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?ft) (thread-read ?th) (email-in-thread ?e ?th) (request-email ?e) (tar-created ?tar))
    :effect (and (replied ?e ?b ?tar))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?e - email ?b - body ?tar - file-path)
    :precondition (and (not (task-completed)) (replied ?e ?b ?tar))
    :effect (and (task-completed))
  )
)
