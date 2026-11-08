(define (domain appworld-98d2608-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship query flag file-path subject body - object
  )
  (:constants
    supervisor phone file-system gmail - app
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (file-matches ?f - file-path ?q - query)
    (known-id ?f - file-path)
    (sent-attachment-to ?p - person ?f - file-path)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?q - query ?rec - flag ?f - file-path)
    :precondition (and (has-token file-system ?t) (file-matches ?f ?q) (not (task-completed)))
    :effect (and (known-id ?f))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?f - file-path ?ft - token ?p - person)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-email ?p ?e) (known-id ?f) (not (sent-attachment-to ?p ?f)) (not (task-completed)))
    :effect (and (sent-attachment-to ?p ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?f - file-path)
    :precondition (and (sent-attachment-to ?p ?f) (not (task-completed)))
    :effect (and (task-completed))
  )
)
