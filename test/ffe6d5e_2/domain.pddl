(define (domain appworld-ffe6d5e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship phone-number note recipe - object)
  (:constants phone simple-note supervisor - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-relationship ?p - person ?r - relationship)
    (phone-number-of ?p - person ?n - phone-number)
    (known-phone ?p - person ?n - phone-number)
    (dinner-request-found ?p - person)
    (note-matches-query ?n - note ?q - query)
    (known-id ?n - note)
    (recipe-in-note ?r - recipe ?n - note)
    (found-recipe ?r - recipe)
    (replied-with-recipe ?p - person ?r - recipe)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known)
                       (username-for phone ?u)
                       (password-for phone ?pw)
                       (not (has-token phone ?t))
                       (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t)
                       (contact-relationship ?p ?r)
                       (phone-number-of ?p ?n)
                       (not (task-completed)))
    :effect (and (known-phone ?p ?n)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person)
    :precondition (and (has-token phone ?t)
                       (known-phone ?p ?n)
                       (not (task-completed)))
    :effect (and (dinner-request-found ?p)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known)
                       (username-for simple-note ?u)
                       (password-for simple-note ?pw)
                       (not (has-token simple-note ?t))
                       (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t)
                       (note-matches-query ?n ?q)
                       (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token ?r - recipe)
    :precondition (and (known-id ?n)
                       (has-token simple-note ?t)
                       (recipe-in-note ?r ?n)
                       (not (task-completed)))
    :effect (and (found-recipe ?r)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?r - recipe ?t - token ?p - person)
    :precondition (and (has-token phone ?t)
                       (known-phone ?p ?n)
                       (dinner-request-found ?p)
                       (found-recipe ?r)
                       (not (task-completed)))
    :effect (and (replied-with-recipe ?p ?r)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?r - recipe)
    :precondition (and (replied-with-recipe ?p ?r)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
