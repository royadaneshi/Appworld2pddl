(define (domain appworld-baeb104-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email-list substring flag directory file subject body - object
  )
  (:constants
    supervisor phone file-system gmail - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (emails-for-relationship ?r - relationship ?el - email-list)
    (known-email-list ?el - email-list)
    (matches-substring ?d - directory ?s - substring)
    (known-id ?d - directory)
    (tar-file ?f - file)
    (archive-created ?f - file ?d - directory)
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
    :parameters (?t - token ?r - relationship ?el - email-list)
    :precondition (and (has-token phone ?t) (emails-for-relationship ?r ?el) (not (task-completed)))
    :effect (known-email-list ?el)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?s - substring ?rec - flag ?d - directory)
    :precondition (and (has-token file-system ?t) (matches-substring ?d ?s) (not (task-completed)))
    :effect (known-id ?d)
  )

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory ?t - token ?f - file)
    :precondition (and (has-token file-system ?t) (known-id ?d) (tar-file ?f) (not (task-completed)))
    :effect (archive-created ?f ?d)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?el - email-list ?s - subject ?b - body ?t - token ?f - file ?ft - token ?d - directory)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-email-list ?el) (archive-created ?f ?d) (not (task-completed)))
    :effect (email-sent ?el ?f)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?el - email-list ?f - file ?d - directory)
    :precondition (and (archive-created ?f ?d) (email-sent ?el ?f) (not (task-completed)))
    :effect (task-completed)
  )
)
