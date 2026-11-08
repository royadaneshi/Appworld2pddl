(define (domain appworld-98d2608-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship query file-path document subject body email-message - object)
  (:constants supervisor phone file-system gmail - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (relationship-of ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (query-for ?d - document ?q - query)
    (file-of ?d - document ?f - file-path)
    (known-path ?d - document ?f - file-path)
    (email-sent ?m - email-message ?p - person ?d - document)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?d - document ?f - file-path)
    :precondition (and (has-token file-system ?t) (query-for ?d ?q) (file-of ?d ?f) (not (task-completed)))
    :effect (and (known-path ?d ?f)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?f - file-path ?fst - token ?p - person ?d - document ?m - email-message)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-email ?p ?e) (known-path ?d ?f) (not (email-sent ?m ?p ?d)) (not (task-completed)))
    :effect (and (email-sent ?m ?p ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?m - email-message ?p - person ?d - document)
    :precondition (and (email-sent ?m ?p ?d) (not (task-completed)))
    :effect (and (task-completed)))
)
