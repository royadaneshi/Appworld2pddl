(define (domain appworld-33e202d-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime
    email-thread applicant attachment file-path content - object)
  (:constants gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (inbox-searched ?q - query)
    (thread-matches ?th - email-thread ?q - query)
    (application-of ?th - email-thread ?ap - applicant)
    (found-applicant-info ?ap - applicant)
    (attachment-of ?att - attachment ?ap - applicant)
    (download-path ?att - attachment ?path - file-path)
    (downloaded ?att - attachment ?path - file-path)
    (csv-spec ?path - file-path ?c - content)
    (csv-covers ?c - content ?ap - applicant)
    (file-created ?path - file-path ?c - content)
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
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (inbox-searched ?q))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - query ?ap - applicant)
    :precondition (and (has-token gmail ?t) (inbox-searched ?q) (thread-matches ?th ?q) (application-of ?th ?ap) (not (task-completed)))
    :effect (found-applicant-info ?ap))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?fst - token ?t - token ?path - file-path ?ap - applicant)
    :precondition (and (has-token file-system ?fst) (has-token gmail ?t) (attachment-of ?att ?ap) (found-applicant-info ?ap) (download-path ?att ?path) (not (task-completed)))
    :effect (downloaded ?att ?path))

  ; API: file_system.create_file
  (:action file-system-create-file
    :parameters (?path - file-path ?t - token ?c - content ?ap - applicant)
    :precondition (and (has-token file-system ?t) (csv-spec ?path ?c) (csv-covers ?c ?ap) (found-applicant-info ?ap) (not (task-completed)))
    :effect (file-created ?path ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?att - attachment ?apath - file-path ?cpath - file-path ?c - content)
    :precondition (and (download-path ?att ?apath) (downloaded ?att ?apath) (csv-spec ?cpath ?c) (file-created ?cpath ?c) (not (task-completed)))
    :effect (task-completed))
)
