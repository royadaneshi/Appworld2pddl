(define (domain appworld-998908e-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query datetime
    email-thread attachment file-path amount - object)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (today-start ?d - datetime)
    (inbox-searched ?q - query)
    (listed-by ?th - email-thread ?q - query)
    (attachment-of ?th - email-thread ?att - attachment)
    (thread-viewed ?th - email-thread)
    (known-id ?att - attachment)
    (download-path ?att - attachment ?p - file-path)
    (downloaded ?att - attachment ?p - file-path)
    (receipt-read ?att - attachment)
    (running-total ?amt - amount)
    (sum-step ?before - amount ?att - attachment ?after - amount)
    (answer-amount ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?since - datetime)
    :precondition (and (has-token gmail ?t) (today-start ?since) (not (task-completed)))
    :effect (inbox-searched ?q))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?q - query ?att - attachment)
    :precondition (and (has-token gmail ?t) (inbox-searched ?q) (listed-by ?th ?q)
                       (attachment-of ?th ?att) (not (task-completed)))
    :effect (and (thread-viewed ?th) (known-id ?att)))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?fst - token ?t - token ?p - file-path)
    :precondition (and (known-id ?att) (has-token file-system ?fst) (has-token gmail ?t)
                       (download-path ?att ?p) (not (task-completed)))
    :effect (downloaded ?att ?p))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?p - file-path ?fst - token ?att - attachment ?before - amount ?after - amount)
    :precondition (and (has-token file-system ?fst) (downloaded ?att ?p)
                       (running-total ?before) (sum-step ?before ?att ?after)
                       (not (receipt-read ?att)) (not (task-completed)))
    :effect (and (receipt-read ?att) (running-total ?after) (not (running-total ?before))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (running-total ?ans) (answer-amount ?ans) (not (task-completed)))
    :effect (task-completed))
)
