(define (domain appworld-e70b117-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query email-thread directory file
    relationship recipient-list body subject send-datetime talk-date - object)
  (:constants
    gmail file-system phone - app
    talk-1 talk-2 talk-3 talk-4 talk-5 talk-6 talk-7 - talk-date
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (contacts-of-relationship ?r - relationship ?rl - recipient-list)
    (known-recipients ?rl - recipient-list)
    (thread-matches ?q - query ?th - email-thread)
    (schedule-thread ?th - email-thread)
    (known-schedule)
    (file-in-directory ?f - file ?dir - directory)
    (template-file ?f - file)
    (template-known)
    (in-schedule ?d - talk-date)
    (body-for ?d - talk-date ?b - body)
    (reminder-time-for ?d - talk-date ?at - send-datetime)
    (reminder-subject ?s - subject)
    (draft-scheduled ?d - talk-date)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?rl - recipient-list)
    :precondition (and (has-token phone ?t) (contacts-of-relationship ?r ?rl) (not (task-completed)))
    :effect (known-recipients ?rl))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?th) (schedule-thread ?th) (not (task-completed)))
    :effect (known-schedule))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?dir - directory ?f - file)
    :precondition (and (has-token file-system ?t) (file-in-directory ?f ?dir) (not (task-completed)))
    :effect (known-id ?f))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token)
    :precondition (and (has-token file-system ?t) (known-id ?f) (template-file ?f) (not (task-completed)))
    :effect (template-known))

  ; API: gmail.create_draft
  (:action gmail-create-draft
    :parameters (?rl - recipient-list ?b - body ?t - token ?s - subject ?at - send-datetime ?d - talk-date)
    :precondition (and (has-token gmail ?t) (known-recipients ?rl) (known-schedule) (template-known)
                       (in-schedule ?d) (body-for ?d ?b) (reminder-time-for ?d ?at) (reminder-subject ?s)
                       (not (draft-scheduled ?d)) (not (task-completed)))
    :effect (draft-scheduled ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (draft-scheduled talk-1)
      (draft-scheduled talk-2)
      (draft-scheduled talk-3)
      (draft-scheduled talk-4)
      (draft-scheduled talk-5)
      (draft-scheduled talk-6)
      (draft-scheduled talk-7)
      (not (task-completed)))
    :effect (task-completed))
)
