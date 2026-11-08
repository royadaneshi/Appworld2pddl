(define (domain appworld-baeb104-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email-list query directory file subject body - object
  )
  (:constants supervisor phone file-system gmail - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (recipients-for ?rel - relationship ?el - email-list)
    (known-recipients ?el - email-list)
    (photos-of ?q - query ?d - directory)
    (directory-found ?d - directory)
    (zip-of ?d - directory ?f - file)
    (zip-created ?f - file)
    (email-sent ?el - email-list ?f - file)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?el - email-list)
    :precondition (and (has-token phone ?t) (recipients-for ?rel ?el) (not (task-completed)))
    :effect (known-recipients ?el)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?d - directory)
    :precondition (and (has-token file-system ?t) (photos-of ?q ?d) (not (task-completed)))
    :effect (directory-found ?d)
  )

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory ?t - token ?f - file)
    :precondition (and (has-token file-system ?t) (directory-found ?d) (zip-of ?d ?f) (not (zip-created ?f)) (not (task-completed)))
    :effect (zip-created ?f)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?el - email-list ?s - subject ?b - body ?t - token ?f - file ?ft - token)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-recipients ?el) (zip-created ?f) (not (email-sent ?el ?f)) (not (task-completed)))
    :effect (email-sent ?el ?f)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?el - email-list ?f - file)
    :precondition (and (email-sent ?el ?f) (not (task-completed)))
    :effect (task-completed)
  )
)
