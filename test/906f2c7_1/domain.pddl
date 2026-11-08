(define (domain appworld-906f2c7-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number email
    text-message directory-path file-path subject body - object)
  (:constants phone file-system gmail - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (known-phone ?p - person ?ph - phone-number)
    (known-email ?p - person ?e - email)
    (message-read ?p - person ?m - text-message)
    (pictures-in ?d - directory-path)
    (file-found ?f - file-path)
    (email-sent ?p - person ?f - file-path)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (token-of phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?ph - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (not (task-completed)))
    :effect (and (known-phone ?p ?ph) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?ph - phone-number ?p - person ?m - text-message ?d - directory-path)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (not (task-completed)))
    :effect (and (message-read ?p ?m) (pictures-in ?d)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (token-of file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?f - file-path)
    :precondition (and (has-token file-system ?t) (pictures-in ?d) (not (task-completed)))
    :effect (file-found ?f))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (token-of gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?f - file-path ?ft - token ?p - person)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-email ?p ?e)
                       (file-found ?f) (not (task-completed)))
    :effect (email-sent ?p ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?f - file-path)
    :precondition (and (email-sent ?p ?f) (not (task-completed)))
    :effect (task-completed))
)
