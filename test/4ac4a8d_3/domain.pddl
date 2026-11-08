(define (domain appworld-4ac4a8d-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query body file-path flag record - object
    thread email-message draft - record)
  (:constants supervisor phone gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (person-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (known-address ?e - email)
    (thread-from ?th - thread ?e - email)
    (email-in-thread ?em - email-message ?th - thread)
    (known-id ?r - record)
    (is-true ?f - flag)
    (body-with-prefix ?b - body)
    (draft-forwards ?d - draft ?em - email-message ?to - email)
    (draft-body-known ?d - draft)
    (draft-prefixed ?d - draft)
    (draft-body-prefixed ?d - draft ?b - body)
    (draft-attached ?d - draft)
    (draft-has-attachment ?d - draft ?f - file-path)
    (draft-sent ?d - draft)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (person-query ?p ?q) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-address ?e)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?from - email ?th - thread)
    :precondition (and (has-token gmail ?t) (known-address ?from) (thread-from ?th ?from) (not (task-completed)))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?em - email-message)
    :precondition (and (has-token gmail ?t) (known-id ?th) (email-in-thread ?em ?th) (not (task-completed)))
    :effect (known-id ?em))

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - thread ?em - email-message ?to - email ?t - token ?dns - flag ?d - draft)
    :precondition (and (has-token gmail ?t) (known-id ?th) (known-id ?em) (email-in-thread ?em ?th) (known-address ?to) (is-true ?dns) (not (known-id ?d)) (not (task-completed)))
    :effect (and (known-id ?d) (draft-forwards ?d ?em ?to)))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (not (draft-sent ?d)) (not (task-completed)))
    :effect (draft-body-known ?d))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body)
    :precondition (and (has-token gmail ?t) (known-id ?d) (draft-body-known ?d) (body-with-prefix ?b) (not (draft-sent ?d)) (not (task-completed)))
    :effect (and (draft-prefixed ?d) (draft-body-prefixed ?d ?b)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?d) (not (draft-sent ?d)) (not (task-completed)))
    :effect (and (draft-attached ?d) (draft-has-attachment ?d ?f)))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (draft-prefixed ?d) (draft-attached ?d) (not (draft-sent ?d)) (not (task-completed)))
    :effect (draft-sent ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?em - email-message ?to - email ?b - body ?f - file-path)
    :precondition (and (draft-sent ?d) (draft-forwards ?d ?em ?to) (draft-body-prefixed ?d ?b) (draft-has-attachment ?d ?f) (not (task-completed)))
    :effect (task-completed))
)
