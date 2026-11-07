(define (domain appworld-29caf6f-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message director note message flag - object
  )
  (:constants phone simple-note - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (message-query ?q - query)
    (request-of ?p - person ?m - text-message)
    (request-director-of ?m - text-message ?d - director)
    (found-request ?m - text-message)
    (known-director ?d - director)
    (note-query ?n - note ?q - query)
    (known-note ?n - note)
    (note-content-known ?n - note)
    (reply-for ?r - message ?d - director ?n - note)
    (message-sent ?p - person ?r - message)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
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
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (and (known-phone-number ?p ?n))
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?q - query ?n - phone-number ?p - person ?m - text-message ?d - director)
    :precondition (and (has-token phone ?t) (message-query ?q) (known-phone-number ?p ?n) (request-of ?p ?m) (request-director-of ?m ?d) (not (task-completed)))
    :effect (and (found-request ?m) (known-director ?d))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?drp - flag ?n - note)
    :precondition (and (has-token simple-note ?t) (note-query ?n ?q) (not (task-completed)))
    :effect (and (known-note ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-note ?n) (not (task-completed)))
    :effect (and (note-content-known ?n))
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?r - message ?t - token ?p - person ?d - director ?note - note)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (known-director ?d) (note-content-known ?note) (reply-for ?r ?d ?note) (not (message-sent ?p ?r)) (not (task-completed)))
    :effect (and (message-sent ?p ?r))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?r - message)
    :precondition (and (message-sent ?p ?r) (not (task-completed)))
    :effect (and (task-completed))
  )
)
