(define (domain appworld-b4707e8-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note username password token query content amount position - object)
  (:constants supervisor simple-note amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?q - query ?n - note)
    (known-id ?n - note)
    (note-content-known ?n - note)
    (current-month-amount ?a - amount)
    (found-month-total ?a - amount)
    (entry-for ?c - content ?a - amount)
    (is-append ?p - position)
    (note-updated ?n - note ?c - content)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (note-content-known ?n))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?a - amount)
    :precondition (and (has-token amazon ?t) (current-month-amount ?a) (not (task-completed)))
    :effect (found-month-total ?a))

  ; API: simple_note.add_content_to_note
  (:action simple-note-add-content-to-note
    :parameters (?n - note ?p - position ?c - content ?t - token ?a - amount)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (note-content-known ?n) (is-append ?p) (found-month-total ?a) (entry-for ?c ?a) (not (note-updated ?n ?c)) (not (task-completed)))
    :effect (note-updated ?n ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?c - content)
    :precondition (and (note-updated ?n ?c) (not (task-completed)))
    :effect (task-completed)))
