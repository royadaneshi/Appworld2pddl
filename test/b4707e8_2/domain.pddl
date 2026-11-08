(define (domain appworld-b4707e8-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note month amount content position - object)
  (:constants simple-note amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?n - note)
    (expense-log ?n - note)
    (known-id ?n - note)
    (found-note-format ?n - note)
    (current-month ?m - month)
    (total-for ?m - month ?amt - amount)
    (found-expense-total ?m - month ?amt - amount)
    (entry-for ?c - content ?m - month ?amt - amount)
    (append-position ?pos - position)
    (note-updated ?n - note ?m - month)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for simple-note ?u) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (query-for ?q ?n) (not (task-completed)))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (found-note-format ?n))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?m - month ?amt - amount)
    :precondition (and (has-token amazon ?t) (current-month ?m) (total-for ?m ?amt) (not (task-completed)))
    :effect (found-expense-total ?m ?amt))

  ; API: simple_note.add_content_to_note
  (:action simple-note-add-content-to-note
    :parameters (?n - note ?pos - position ?c - content ?t - token ?m - month ?amt - amount)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (found-note-format ?n) (expense-log ?n) (append-position ?pos) (found-expense-total ?m ?amt) (entry-for ?c ?m ?amt) (not (task-completed)))
    :effect (note-updated ?n ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?m - month)
    :precondition (and (expense-log ?n) (current-month ?m) (note-updated ?n ?m) (not (task-completed)))
    :effect (task-completed))
)
