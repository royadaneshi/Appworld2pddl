(define (domain appworld-906f2c7-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message email-address file substring subject body - object)
  (:constants
    phone file-system gmail - app
    lindsey - person
    vacation-pictures-file - file)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (phone-number-of ?p - person ?n - phone-number)
    (email-of ?p - person ?e - email-address)
    (known-phone-number ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email-address)
    (message-from ?m - text-message ?p - person)
    (message-about-file ?m - text-message ?f - file)
    (found-message ?m - text-message)
    (file-wanted ?f - file)
    (substring-for ?s - substring ?f - file)
    (known-path ?f - file)
    (email-sent ?p - person ?f - file)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-of phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?e - email-address)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (phone-number-of ?p ?n) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-phone-number ?p ?n) (known-email ?p ?e)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - text-message ?f - file)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (message-from ?m ?p) (message-about-file ?m ?f) (not (task-completed)))
    :effect (and (found-message ?m) (file-wanted ?f)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-of file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?s - substring ?f - file)
    :precondition (and (has-token file-system ?t) (file-wanted ?f) (substring-for ?s ?f) (not (task-completed)))
    :effect (and (known-path ?f)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-of gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email-address ?s - subject ?b - body ?t - token ?f - file ?fst - token ?p - person)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-email ?p ?e) (file-wanted ?f) (known-path ?f) (not (email-sent ?p ?f)) (not (task-completed)))
    :effect (and (email-sent ?p ?f)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (email-sent lindsey vacation-pictures-file) (not (task-completed)))
    :effect (and (task-completed)))
)
