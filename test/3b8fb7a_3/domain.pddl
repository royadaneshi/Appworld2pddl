(define (domain appworld-3b8fb7a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note username password token query email amount description privacy - object
  )
  (:constants
    supervisor simple-note venmo - app
    friend-i-owe-1 friend-i-owe-2 friend-owes-me-1 friend-owes-me-2 friend-owes-me-3 - person
    amount-i-owe-1 amount-i-owe-2 amount-owed-to-me-1 amount-owed-to-me-2 amount-owed-to-me-3 - amount
    desc-for-miami-trip - description
    private-true - privacy
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (note-lists-i-owe ?n - note ?p - person ?amt - amount)
    (note-lists-owes-me ?n - note ?p - person ?amt - amount)
    (venmo-email ?p - person ?e - email)
    (trip-description ?d - description)
    (private-setting ?priv - privacy)
    (paid ?p - person ?amt - amount ?d - description ?priv - privacy)
    (requested ?p - person ?amt - amount ?d - description ?priv - privacy)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
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
    :effect (has-token simple-note ?t)
  )

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and
      (has-token simple-note ?t)
      (note-matches ?n ?q)
      (not (task-completed))
    )
    :effect (known-id ?n)
  )

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and
      (has-token simple-note ?t)
      (known-id ?n)
      (not (task-completed))
    )
    :effect (note-read ?n)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (passwords-known)
      (username-for venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t))
      (not (task-completed))
    )
    :effect (has-token venmo ?t)
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?priv - privacy ?p - person ?n - note)
    :precondition (and
      (has-token venmo ?t)
      (note-read ?n)
      (note-lists-i-owe ?n ?p ?amt)
      (venmo-email ?p ?e)
      (trip-description ?d)
      (private-setting ?priv)
      (not (paid ?p ?amt ?d ?priv))
      (not (task-completed))
    )
    :effect (paid ?p ?amt ?d ?priv)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?priv - privacy ?p - person ?n - note)
    :precondition (and
      (has-token venmo ?t)
      (note-read ?n)
      (note-lists-owes-me ?n ?p ?amt)
      (venmo-email ?p ?e)
      (trip-description ?d)
      (private-setting ?priv)
      (not (requested ?p ?amt ?d ?priv))
      (not (task-completed))
    )
    :effect (requested ?p ?amt ?d ?priv)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (paid friend-i-owe-1 amount-i-owe-1 desc-for-miami-trip private-true)
      (paid friend-i-owe-2 amount-i-owe-2 desc-for-miami-trip private-true)
      (requested friend-owes-me-1 amount-owed-to-me-1 desc-for-miami-trip private-true)
      (requested friend-owes-me-2 amount-owed-to-me-2 desc-for-miami-trip private-true)
      (requested friend-owes-me-3 amount-owed-to-me-3 desc-for-miami-trip private-true)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
