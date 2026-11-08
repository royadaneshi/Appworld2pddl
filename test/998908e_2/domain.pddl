(define (domain appworld-998908e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime amount record file-path - object
    email-thread attachment - record)
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (booking-query ?q - query)
    (day-start ?d - datetime)
    (booking-thread ?th - email-thread)
    (has-attachment ?th - email-thread ?at - attachment)
    (attachment-file ?at - attachment ?f - file-path)
    (total-of ?amt - amount ?f1 - file-path ?f2 - file-path ?f3 - file-path)
    (booking-threads-found)
    (known-id ?x - record)
    (downloaded ?f - file-path)
    (receipt-read ?f - file-path)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?d - datetime)
    :precondition (and (has-token gmail ?t) (booking-query ?q) (day-start ?d) (not (task-completed)))
    :effect (booking-threads-found))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (booking-threads-found) (booking-thread ?th) (has-attachment ?th ?at) (not (task-completed)))
    :effect (known-id ?at))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?f - file-path)
    :precondition (and (has-token file-system ?fst) (has-token gmail ?t) (known-id ?at) (attachment-file ?at ?f) (not (downloaded ?f)) (not (task-completed)))
    :effect (downloaded ?f))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?fst - token)
    :precondition (and (has-token file-system ?fst) (downloaded ?f) (not (task-completed)))
    :effect (receipt-read ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount ?f1 - file-path ?f2 - file-path ?f3 - file-path)
    :precondition (and (total-of ?answer ?f1 ?f2 ?f3) (receipt-read ?f1) (receipt-read ?f2) (receipt-read ?f3) (not (task-completed)))
    :effect (task-completed))
)
