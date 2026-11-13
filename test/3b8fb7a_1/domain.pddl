(define (domain appworld-3b8fb7a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token note query email amount description privacy - object)
  (:constants
    supervisor simple-note venmo - app
    note-maui-trip - note
    friend-1 friend-2 friend-3 friend-4 friend-5 friend-6 - person
    amount-i-owe-friend-1 amount-i-owe-friend-2 amount-i-owe-friend-3 amount-friend-owes-me-1 amount-friend-owes-me-2 amount-friend-owes-me-3 - amount
    desc-for-maui-trip - description
    private-true - privacy
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (listed-in ?n - note ?p - person)
    (i-owe ?n - note ?p - person ?amt - amount)
    (owes-me ?n - note ?p - person ?amt - amount)
    (query-for ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (paid ?p - person ?amt - amount ?d - description ?pv - privacy)
    (requested ?p - person ?amt - amount ?d - description ?pv - privacy)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app simple-note ?t) (credential-of-app simple-note ?pw) (credential-of-app simple-note ?u) (passwords-known) (password-for simple-note ?pw) (not (has-token simple-note ?t)) (not (task-completed)))
    :effect (and (has-token simple-note ?t)))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (has-token simple-note ?t) (note-matches ?n ?q) (not (task-completed)))
    :effect (and (known-id ?n)))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (has-token simple-note ?t) (known-id ?n) (not (task-completed)))
    :effect (and (note-read ?n)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?q - query ?p - person ?e - email ?n - note)
    :precondition (and (has-token venmo ?t) (note-read ?n) (listed-in ?n ?p) (query-for ?p ?q) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?pv - privacy ?p - person ?n - note)
    :precondition (and (has-token venmo ?t) (note-read ?n) (i-owe ?n ?p ?amt) (known-email ?p ?e) (not (paid ?p ?amt ?d ?pv)) (not (task-completed)))
    :effect (and (paid ?p ?amt ?d ?pv)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?pv - privacy ?p - person ?n - note)
    :precondition (and (has-token venmo ?t) (note-read ?n) (owes-me ?n ?p ?amt) (known-email ?p ?e) (not (requested ?p ?amt ?d ?pv)) (not (task-completed)))
    :effect (and (requested ?p ?amt ?d ?pv)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (paid friend-1 amount-i-owe-friend-1 desc-for-maui-trip private-true)
      (paid friend-2 amount-i-owe-friend-2 desc-for-maui-trip private-true)
      (paid friend-3 amount-i-owe-friend-3 desc-for-maui-trip private-true)
      (requested friend-4 amount-friend-owes-me-1 desc-for-maui-trip private-true)
      (requested friend-5 amount-friend-owes-me-2 desc-for-maui-trip private-true)
      (requested friend-6 amount-friend-owes-me-3 desc-for-maui-trip private-true)
      (not (task-completed)))
    :effect (and (task-completed)))
)
