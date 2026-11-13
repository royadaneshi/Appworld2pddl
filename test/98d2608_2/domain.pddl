(define (domain appworld-98d2608-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship substring flag filepath subject body - object)
  (:constants supervisor phone file-system gmail - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (file-matches ?s - substring ?f - filepath)
    (is-true ?x - flag)
    (known-file-path ?f - filepath)
    (email-sent ?p - person ?f - filepath)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?s - substring ?rec - flag ?f - filepath)
    :precondition (and (has-token file-system ?t) (file-matches ?s ?f) (is-true ?rec) (not (task-completed)))
    :effect (known-file-path ?f))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?subj - subject ?b - body ?t - token ?f - filepath ?ft - token ?p - person)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-email ?p ?e) (known-file-path ?f) (not (email-sent ?p ?f)) (not (task-completed)))
    :effect (email-sent ?p ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?f - filepath)
    :precondition (and (email-sent ?p ?f) (not (task-completed)))
    :effect (task-completed))
)
