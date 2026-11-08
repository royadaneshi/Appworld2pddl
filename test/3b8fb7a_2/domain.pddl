(define (domain appworld-3b8fb7a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person note token username password query email amount description privacy - object)
  (:constants
    supervisor simple-note venmo - app
    athens-trip-note - note
    friend-i-owe-1 friend-i-owe-2 friend-owes-me-1 friend-owes-me-2 - person
    amount-i-owe-1 amount-i-owe-2 amount-owes-me-1 amount-owes-me-2 - amount
    note-for-athens-trip - description
    private-true - privacy)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (i-owe ?n - note ?p - person ?amt - amount)
    (they-owe ?n - note ?p - person ?amt - amount)
    (friends-listed)
    (friend-email ?p - person ?e - email)
    (paid ?p - person ?amt - amount ?d - description ?priv - privacy)
    (requested ?p - person ?amt - amount ?d - description ?priv - privacy)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for simple-note ?pw) (token-for simple-note ?t) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?n ?q) (not (known-id ?n)) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (note-read ?n)) (not (task-completed)))
    :effect (and (note-read ?n)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (friends-listed)) (not (task-completed)))
    :effect (and (friends-listed)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?priv - privacy ?p - person ?n - note)
    :precondition (and (has-token venmo ?t) (note-read ?n) (i-owe ?n ?p ?amt) (friends-listed) (friend-email ?p ?e) (not (paid ?p ?amt ?d ?priv)) (not (task-completed)))
    :effect (and (paid ?p ?amt ?d ?priv)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?priv - privacy ?p - person ?n - note)
    :precondition (and (has-token venmo ?t) (note-read ?n) (they-owe ?n ?p ?amt) (friends-listed) (friend-email ?p ?e) (not (requested ?p ?amt ?d ?priv)) (not (task-completed)))
    :effect (and (requested ?p ?amt ?d ?priv)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (paid friend-i-owe-1 amount-i-owe-1 note-for-athens-trip private-true)
      (paid friend-i-owe-2 amount-i-owe-2 note-for-athens-trip private-true)
      (requested friend-owes-me-1 amount-owes-me-1 note-for-athens-trip private-true)
      (requested friend-owes-me-2 amount-owes-me-2 note-for-athens-trip private-true)
      (not (task-completed)))
    :effect (and (task-completed)))
)
