(define (domain appworld-22cc237-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship note amount description direction datetime - object)
  (:constants
    phone simple-note venmo - app
    coworker-stephen coworker-sabrina coworker-jamie coworker-allison coworker-stacy coworker-travis coworker-kristin coworker-anita coworker-kayla - person)
  (:predicates
    (profile-known)
    (passwords-known)
    (date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contact-query ?q - query)
    (contact-relationship ?r - relationship)
    (contacts-searched)
    (coworker-email ?p - person ?e - email)
    (note-query ?q - query)
    (note-for-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (share-in-note ?n - note ?p - person ?amt - amount)
    (date-yesterday ?d - datetime)
    (direction-received ?dir - direction)
    (transactions-checked)
    (already-paid ?p - person)
    (request-description ?desc - description)
    (payment-requested ?p - person)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (contact-query ?q) (contact-relationship ?r) (not (task-completed)))
    :effect (and (contacts-searched)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (date-known) (note-query ?q) (note-for-query ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (known-id ?n) (has-token simple-note ?t) (not (task-completed)))
    :effect (and (note-read ?n)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - datetime ?dir - direction)
    :precondition (and (has-token venmo ?t) (date-known) (date-yesterday ?d) (direction-received ?dir) (not (task-completed)))
    :effect (and (transactions-checked)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?desc - description ?p - person ?n - note)
    :precondition (and (has-token venmo ?t) (contacts-searched) (coworker-email ?p ?e) (note-read ?n) (share-in-note ?n ?p ?amt) (transactions-checked) (not (already-paid ?p)) (request-description ?desc) (not (payment-requested ?p)) (not (task-completed)))
    :effect (and (payment-requested ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (payment-requested coworker-stephen)
      (payment-requested coworker-sabrina)
      (payment-requested coworker-jamie)
      (payment-requested coworker-anita)
      (not (payment-requested coworker-allison))
      (not (payment-requested coworker-stacy))
      (not (payment-requested coworker-travis))
      (not (payment-requested coworker-kristin))
      (not (payment-requested coworker-kayla))
      (not (task-completed)))
    :effect (and (task-completed)))
)
