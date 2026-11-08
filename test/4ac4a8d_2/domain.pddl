(define (domain appworld-4ac4a8d-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email thread draft file-path body-text flag datetime - object)
  (:constants gmail phone file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (thread-from ?th - thread ?p - person)
    (known-thread ?th - thread)
    (thread-inspected ?th - thread)
    (forward-target ?p - person)
    (is-true ?f - flag)
    (yesterday ?d - datetime)
    (draft-exists ?d - draft)
    (forward-draft-of ?d - draft ?th - thread ?to - email)
    (draft-body-known ?d - draft)
    (prefixed-body ?b - body-text)
    (draft-body-prefixed ?d - draft)
    (my-expenses-file ?f - file-path)
    (draft-attached ?d - draft ?f - file-path)
    (forwarded ?th - thread ?to - email)
    (sent-with-attachment ?th - thread ?f - file-path)
    (sent-with-prefix ?th - thread)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (query-for ?q ?p) (email-of ?p ?e))
    :effect (known-email ?p ?e))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?from - email ?att - flag ?since - datetime ?p - person ?th - thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-email ?p ?from) (thread-from ?th ?p) (is-true ?att) (yesterday ?since))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-thread ?th))
    :effect (thread-inspected ?th))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  ; API: gmail.forward_email_thread
  (:action gmail-forward-email-thread
    :parameters (?th - thread ?to - email ?t - token ?dns - flag ?p - person ?d - draft)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (thread-inspected ?th) (known-email ?p ?to) (forward-target ?p) (is-true ?dns) (not (draft-exists ?d)))
    :effect (and (draft-exists ?d) (forward-draft-of ?d ?th ?to)))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (draft-exists ?d))
    :effect (draft-body-known ?d))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body-text)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (draft-exists ?d) (draft-body-known ?d) (prefixed-body ?b))
    :effect (draft-body-prefixed ?d))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?fst) (draft-exists ?d) (my-expenses-file ?f))
    :effect (draft-attached ?d ?f))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token ?th - thread ?to - email ?f - file-path)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (draft-exists ?d) (forward-draft-of ?d ?th ?to) (draft-body-prefixed ?d) (draft-attached ?d ?f))
    :effect (and (not (draft-exists ?d)) (forwarded ?th ?to) (sent-with-attachment ?th ?f) (sent-with-prefix ?th)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?th - thread ?to - email ?f - file-path)
    :precondition (and (not (task-completed)) (forwarded ?th ?to) (sent-with-attachment ?th ?f) (sent-with-prefix ?th))
    :effect (task-completed))
)
