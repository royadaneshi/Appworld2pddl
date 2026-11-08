(define (domain appworld-b4707e8-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query note month amount content position - object
  )
  (:constants
    simple-note amazon - app
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (note-query ?q - query ?n - note)
    (known-id ?n - note)
    (note-content-known ?n - note)
    (current-month ?m - month)
    (amount-for-month ?m - month ?amt - amount)
    (month-total-known ?m - month ?amt - amount)
    (entry-content ?c - content ?m - month ?amt - amount)
    (append-mode ?pos - position)
    (note-updated ?n - note ?m - month)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for simple-note ?u)
      (password-for simple-note ?pw)
      (not (has-token simple-note ?t))
      (not (task-completed))
    )
    :effect (and (has-token simple-note ?t))
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and
      (has-token simple-note ?t)
      (note-query ?q ?n)
      (not (task-completed))
    )
    :effect (and (known-id ?n))
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and
      (has-token simple-note ?t)
      (known-id ?n)
      (not (task-completed))
    )
    :effect (and (note-content-known ?n))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for amazon ?u)
      (password-for amazon ?pw)
      (not (has-token amazon ?t))
      (not (task-completed))
    )
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?m - month ?amt - amount)
    :precondition (and
      (has-token amazon ?t)
      (current-month ?m)
      (amount-for-month ?m ?amt)
      (not (task-completed))
    )
    :effect (and (month-total-known ?m ?amt))
  )

  ; API: simple_note.add_content_to_note
  (:action simple-note-add-content-to-note
    :parameters (?n - note ?pos - position ?c - content ?t - token ?m - month ?amt - amount)
    :precondition (and
      (has-token simple-note ?t)
      (known-id ?n)
      (note-content-known ?n)
      (append-mode ?pos)
      (month-total-known ?m ?amt)
      (entry-content ?c ?m ?amt)
      (not (note-updated ?n ?m))
      (not (task-completed))
    )
    :effect (and (note-updated ?n ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - note ?m - month)
    :precondition (and
      (note-updated ?n ?m)
      (not (task-completed))
    )
    :effect (and (task-completed))
  )
)
