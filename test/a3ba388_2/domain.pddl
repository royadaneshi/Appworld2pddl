(define (domain appworld-a3ba388-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship draft query file-path datetime - object
  )
  (:constants
    supervisor phone gmail file-system - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (is-manager ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (draft-matches ?d - draft ?q - query)
    (known-id ?d - draft)
    (current-datetime-known)
    (target-draft ?d - draft)
    (target-file ?f - file-path)
    (target-datetime ?dt - datetime)
    (attached ?d - draft ?f - file-path)
    (scheduled ?d - draft ?e - email ?dt - datetime)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-datetime-known))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?d ?q) (not (task-completed)))
    :effect (and (known-id ?d))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.upload_attachments_to_draft
  (:action gmail-upload-attachments-to-draft
    :parameters (?d - draft ?f - file-path ?fst - token ?t - token)
    :precondition (and (known-id ?d) (has-token file-system ?fst) (has-token gmail ?t) (not (task-completed)))
    :effect (and (attached ?d ?f))
  )

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?e - email ?dt - datetime ?p - person)
    :precondition (and (known-id ?d) (has-token gmail ?t) (is-manager ?p) (known-email ?p ?e) (current-datetime-known) (target-datetime ?dt) (not (task-completed)))
    :effect (and (scheduled ?d ?e ?dt))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft ?f - file-path ?e - email ?dt - datetime)
    :precondition (and (target-draft ?d) (target-file ?f) (target-datetime ?dt) (attached ?d ?f) (scheduled ?d ?e ?dt) (not (task-completed)))
    :effect (and (task-completed))
  )
)
