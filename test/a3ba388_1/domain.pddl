(define (domain appworld-a3ba388-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query draft file-path datetime relationship - object)
  (:constants gmail phone file-system - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (current-datetime-known)
    (relationship-of ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (is-manager ?p - person)
    (draft-matches ?q - query ?d - draft)
    (known-id ?d - draft)
    (file-at ?f - file-path)
    (target-send-time ?dt - datetime)
    (attached ?f - file-path ?d - draft)
    (draft-recipient ?d - draft ?e - email)
    (draft-scheduled ?d - draft ?dt - datetime)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-datetime-known))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?q ?d) (not (task-completed)))
    :effect (known-id ?d))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?ft - token ?t - token)
    :precondition (and (known-id ?d) (file-at ?f) (has-token file-system ?ft) (has-token gmail ?t) (not (task-completed)))
    :effect (attached ?f ?d))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?e - email ?dt - datetime ?p - person)
    :precondition (and (known-id ?d) (has-token gmail ?t) (is-manager ?p) (known-email ?p ?e) (target-send-time ?dt) (current-datetime-known) (not (task-completed)))
    :effect (and (draft-recipient ?d ?e) (draft-scheduled ?d ?dt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?f - file-path ?e - email ?dt - datetime ?p - person)
    :precondition (and (attached ?f ?d) (draft-recipient ?d ?e) (draft-scheduled ?d ?dt) (is-manager ?p) (known-email ?p ?e) (target-send-time ?dt) (not (task-completed)))
    :effect (task-completed))
)
