(define (domain appworld-4ac4a8d-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email thread draft body filepath boolean - object)
  (:constants supervisor phone gmail file-system - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (thread-from ?th - thread ?p - person)
    (known-thread ?th - thread)
    (thread-inspected ?th - thread)
    (flag-true ?f - boolean)
    (draft-created ?d - draft)
    (draft-of ?d - draft ?th - thread)
    (draft-to ?d - draft ?e - email)
    (draft-body-known ?d - draft)
    (note-prefixed-body ?b - body)
    (draft-body-prefixed ?d - draft)
    (attachment-file ?f - filepath)
    (draft-has-attachment ?d - draft)
    (draft-sent ?d - draft)
    (thread-forwarded ?th - thread ?e - email)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?from - email ?p - person ?th - thread)
    :precondition (and (has-token gmail ?t) (known-email ?p ?from) (thread-from ?th ?p) (not (task-completed)))
    :effect (and (known-thread ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token)
    :precondition (and (known-thread ?th) (has-token gmail ?t) (not (task-completed)))
    :effect (and (thread-inspected ?th)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.forward_email_thread
  (:action gmail-forward-email-thread
    :parameters (?th - thread ?e - email ?t - token ?dns - boolean ?d - draft ?p - person)
    :precondition (and (known-thread ?th) (thread-inspected ?th) (known-email ?p ?e) (has-token gmail ?t) (flag-true ?dns) (not (draft-created ?d)) (not (task-completed)))
    :effect (and (draft-created ?d) (draft-of ?d ?th) (draft-to ?d ?e)))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (draft-created ?d) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-body-known ?d)))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body)
    :precondition (and (draft-created ?d) (draft-body-known ?d) (note-prefixed-body ?b) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-body-prefixed ?d)))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - filepath ?ft - token ?t - token)
    :precondition (and (draft-created ?d) (attachment-file ?f) (has-token file-system ?ft) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-has-attachment ?d)))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token ?th - thread ?e - email)
    :precondition (and (draft-created ?d) (not (draft-sent ?d)) (draft-of ?d ?th) (draft-to ?d ?e) (draft-body-prefixed ?d) (draft-has-attachment ?d) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-sent ?d) (thread-forwarded ?th ?e)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?th - thread ?e - email)
    :precondition (and (thread-forwarded ?th ?e) (not (task-completed)))
    :effect (and (task-completed))))
