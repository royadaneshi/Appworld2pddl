(define (domain appworld-22cc237-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship note amount description direction datetime - object)
  (:constants
    phone simple-note venmo - app
    dinner-friend-2 dinner-friend-3 - person
    amount-share-2 amount-share-3 - amount
    description-friends-dinner - description)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-datetime-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (relationship-query ?rel - relationship ?q - query)
    (contacts-searched)
    (contact-email ?p - person ?e - email)
    (note-matches ?n - note ?q - query)
    (known-id ?n - note)
    (note-read ?n - note)
    (share-in-note ?n - note ?p - person ?a - amount)
    (transactions-checked)
    (already-paid ?p - person)
    (payment-request-created ?p - person ?a - amount ?d - description)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-datetime-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (relationship-query ?rel ?q))
    :effect (contacts-searched))

  ; API: simple_note.login
  (:action simple-note-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for simple-note ?u) (password-for simple-note ?pw)
                       (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  ; API: simple_note.search_notes
  (:action simple-note-search-notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t)
                       (current-datetime-known) (note-matches ?n ?q))
    :effect (known-id ?n))

  ; API: simple_note.show_note
  (:action simple-note-show-note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n))
    :effect (note-read ?n))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?dir - direction ?since - datetime)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (current-datetime-known))
    :effect (transactions-checked))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?a - amount ?t - token ?d - description ?p - person ?n - note)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (contacts-searched) (contact-email ?p ?e)
                       (note-read ?n) (share-in-note ?n ?p ?a)
                       (transactions-checked) (not (already-paid ?p))
                       (not (payment-request-created ?p ?a ?d)))
    :effect (payment-request-created ?p ?a ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (payment-request-created dinner-friend-2 amount-share-2 description-friends-dinner)
                       (payment-request-created dinner-friend-3 amount-share-3 description-friends-dinner))
    :effect (task-completed))
)
