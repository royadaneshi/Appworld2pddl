(define (domain appworld-29caf6f-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message note director message - object
  )
  (:constants phone simple-note - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-query ?m - text-message ?q - query)
    (request-from ?m - text-message ?p - person)
    (mentions-director ?m - text-message ?d - director)
    (found-request ?m - text-message)
    (known-director ?d - director)
    (note-query ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (reply-content ?msg - message ?d - director ?n - note)
    (text-sent ?p - person ?msg - message)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (known-phone-number ?p ?n)
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?q - query ?n - phone-number ?m - text-message ?p - person ?d - director)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (message-query ?m ?q) (request-from ?m ?p) (mentions-director ?m ?d) (not (task-completed)))
    :effect (and (found-request ?m) (known-director ?d))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (profile-known) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?n ?q) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (note-read ?n)
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?msg - message ?t - token ?p - person ?d - director ?note - note)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (known-director ?d) (note-read ?note) (reply-content ?msg ?d ?note) (not (task-completed)))
    :effect (text-sent ?p ?msg)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?msg - message)
    :precondition (and (text-sent ?p ?msg) (not (task-completed)))
    :effect (task-completed)
  )
)
