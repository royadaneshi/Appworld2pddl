(define (domain appworld-baeb104-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email-list substring flag directory zipfile subject body - object)
  (:constants supervisor phone file-system gmail - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (contacts-with ?r - relationship ?el - email-list)
    (known-emails ?el - email-list)
    (directory-matches ?d - directory ?s - substring)
    (known-directory ?d - directory)
    (archive-of ?d - directory ?z - zipfile)
    (zip-ready ?z - zipfile)
    (email-sent ?el - email-list ?z - zipfile)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?el - email-list)
    :precondition (and (has-token phone ?t) (contacts-with ?r ?el) (not (task-completed)))
    :effect (known-emails ?el))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?s - substring ?rec - flag ?d - directory)
    :precondition (and (has-token file-system ?t) (directory-matches ?d ?s) (not (task-completed)))
    :effect (known-directory ?d))

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - directory ?t - token ?z - zipfile)
    :precondition (and (has-token file-system ?t) (known-directory ?d) (archive-of ?d ?z) (not (task-completed)))
    :effect (zip-ready ?z))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?el - email-list ?subj - subject ?body - body ?t - token ?z - zipfile ?fst - token)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-emails ?el) (zip-ready ?z) (not (task-completed)))
    :effect (email-sent ?el ?z))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?el - email-list ?z - zipfile)
    :precondition (and (email-sent ?el ?z) (not (task-completed)))
    :effect (task-completed))
)
