(define (domain appworld-998908e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread attachment file-path amount - object
  )
  (:constants gmail file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (matches-query ?th - email-thread ?q - query)
    (searched-inbox ?q - query)
    (thread-shown ?th - email-thread)
    (attachment-of ?att - attachment ?th - email-thread)
    (download-path ?att - attachment ?f - file-path)
    (downloaded ?att - attachment ?f - file-path)
    (read-receipt ?f - file-path)
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
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (and (searched-inbox ?q))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - query)
    :precondition (and (has-token gmail ?t) (searched-inbox ?q) (matches-query ?th ?q) (not (task-completed)))
    :effect (and (thread-shown ?th))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?fst - token ?t - token ?th - email-thread ?f - file-path)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (thread-shown ?th) (attachment-of ?att ?th) (download-path ?att ?f) (not (task-completed)))
    :effect (and (downloaded ?att ?f))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token ?att - attachment)
    :precondition (and (has-token file-system ?t) (downloaded ?att ?f) (not (task-completed)))
    :effect (and (read-receipt ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount ?f1 - file-path ?f2 - file-path ?f3 - file-path)
    :precondition (and (read-receipt ?f1) (read-receipt ?f2) (read-receipt ?f3) (not (= ?f1 ?f2)) (not (= ?f1 ?f3)) (not (= ?f2 ?f3)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
