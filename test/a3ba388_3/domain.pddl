(define (domain appworld-a3ba388-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token draft file-path email query relationship datetime - object)
  (:constants gmail phone file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (draft-matches ?d - draft ?q - query)
    (known-id ?d - draft)
    (contact-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (current-date-known)
    (attachment-target ?d - draft ?f - file-path)
    (recipient-target ?d - draft ?p - person)
    (schedule-target ?d - draft ?dt - datetime)
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
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?d ?q) (not (task-completed)))
    :effect (known-id ?d))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token)
    :precondition (and (known-id ?d) (has-token file-system ?fst) (has-token gmail ?t) (not (attached ?f ?d)) (not (task-completed)))
    :effect (attached ?f ?d))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?e - email ?dt - datetime ?p - person)
    :precondition (and (known-id ?d) (has-token gmail ?t) (known-email ?p ?e) (recipient-target ?d ?p) (current-date-known) (schedule-target ?d ?dt) (not (task-completed)))
    :effect (and (draft-recipient ?d ?e) (draft-scheduled ?d ?dt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?f - file-path ?p - person ?e - email ?dt - datetime)
    :precondition (and (attachment-target ?d ?f) (recipient-target ?d ?p) (email-of ?p ?e) (schedule-target ?d ?dt) (attached ?f ?d) (draft-recipient ?d ?e) (draft-scheduled ?d ?dt) (not (task-completed)))
    :effect (task-completed))
)
