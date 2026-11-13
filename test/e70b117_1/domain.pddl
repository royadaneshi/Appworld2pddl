(define (domain appworld-e70b117-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread relationship recipients
    directory-path file-path talk send-datetime subject body - object)
  (:constants supervisor gmail phone file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (found-thread ?th - email-thread)
    (schedule-known)
    (known-coworkers ?r - recipients)
    (known-file ?f - file-path)
    (template-known)
    (required-subject ?s - subject)
    (talk-date ?k - talk ?d - send-datetime)
    (talk-body ?k - talk ?b - body)
    (draft-scheduled ?k - talk)
    (task-completed))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action gmail-login
    ; API: gmail.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  (:action file-system-login
    ; API: file_system.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  (:action gmail-show-inbox-threads
    ; API: gmail.show_inbox_threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (not (task-completed)))
    :effect (found-thread ?th))

  (:action gmail-show-thread
    ; API: gmail.show_thread
    :parameters (?th - email-thread ?t - token)
    :precondition (and (has-token gmail ?t) (found-thread ?th) (not (task-completed)))
    :effect (schedule-known))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?rel - relationship ?r - recipients)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (known-coworkers ?r))

  (:action file-system-show-directory
    ; API: file_system.show_directory
    :parameters (?t - token ?dir - directory-path ?f - file-path)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (known-file ?f))

  (:action file-system-show-file
    ; API: file_system.show_file
    :parameters (?f - file-path ?t - token)
    :precondition (and (has-token file-system ?t) (known-file ?f) (not (task-completed)))
    :effect (template-known))

  (:action gmail-create-draft
    ; API: gmail.create_draft
    :parameters (?r - recipients ?b - body ?t - token ?s - subject ?d - send-datetime ?k - talk)
    :precondition (and (has-token gmail ?t) (known-coworkers ?r) (schedule-known) (template-known)
                       (required-subject ?s) (talk-date ?k ?d) (talk-body ?k ?b)
                       (not (draft-scheduled ?k)) (not (task-completed)))
    :effect (draft-scheduled ?k))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?k1 ?k2 ?k3 ?k4 - talk)
    :precondition (and (draft-scheduled ?k1) (draft-scheduled ?k2) (draft-scheduled ?k3) (draft-scheduled ?k4)
                       (not (= ?k1 ?k2)) (not (= ?k1 ?k3)) (not (= ?k1 ?k4))
                       (not (= ?k2 ?k3)) (not (= ?k2 ?k4)) (not (= ?k3 ?k4))
                       (not (task-completed)))
    :effect (task-completed))
)
