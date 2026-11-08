(define (domain appworld-ffe6d5e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token phone-number relationship query note recipe message - object
  )
  (:constants phone simple-note - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?rel - relationship)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone-number ?p - person ?n - phone-number)
    (found-dinner-question ?p - person)
    (note-matches ?q - query ?n - note)
    (known-id ?n - note)
    (recipe-in-note ?r - recipe ?n - note)
    (is-favorite ?r - recipe)
    (found-recipe ?r - recipe)
    (message-names ?m - message ?r - recipe)
    (replied-with-recipe ?p - person ?r - recipe)
    (task-completed)
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
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?rel) (phone-number-of ?p ?n) (not (task-completed)))
    :effect (known-phone-number ?p ?n)
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (not (task-completed)))
    :effect (found-dinner-question ?p)
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?q ?n) (not (task-completed)))
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?r - recipe)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (recipe-in-note ?r ?n) (not (task-completed)))
    :effect (found-recipe ?r)
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?r - recipe)
    :precondition (and (has-token phone ?t) (known-phone-number ?p ?n) (found-dinner-question ?p) (found-recipe ?r) (is-favorite ?r) (message-names ?m ?r) (not (task-completed)))
    :effect (replied-with-recipe ?p ?r)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?r - recipe)
    :precondition (and (replied-with-recipe ?p ?r) (not (task-completed)))
    :effect (task-completed)
  )
)
