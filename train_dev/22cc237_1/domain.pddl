(define (domain appworld-22cc237-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship note amount description direction date - object)
  (:constants
    phone simple-note venmo - app
    coworker-1 coworker-5 coworker-6 coworker-2 coworker-3 coworker-7 coworker-4 - person
    share-coworker-1 share-coworker-5 share-coworker-6 share-coworker-2 share-coworker-3 share-coworker-7 share-coworker-4 - amount
    work-dinner - description)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-datetime-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-of ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contact-query ?q - query)
    (note-query ?q - query)
    (coworkers-found)
    (coworker-email ?p - person ?e - email)
    (known-id ?n - note)
    (shares-known)
    (share ?p - person ?amt - amount)
    (transactions-checked)
    (already-paid ?p - person)
    (payment-request-sent ?p - person ?amt - amount ?d - description)
    (task-completed))

  (:action supervisor-show-profile
    ; API: supervisor.show_profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action phone-get-current-date-and-time
    ; API: phone.get_current_date_and_time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-datetime-known))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw) (token-of phone ?t)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (contact-query ?q))
    :effect (coworkers-found))

  (:action simple-note-login
    ; API: simple_note.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for simple-note ?u) (password-for simple-note ?pw) (token-of simple-note ?t)
                       (not (has-token simple-note ?t)))
    :effect (has-token simple-note ?t))

  (:action simple-note-search-notes
    ; API: simple_note.search_notes
    :parameters (?t - token ?q - query ?n - note)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (note-query ?q)
                       (current-datetime-known) (not (known-id ?n)))
    :effect (known-id ?n))

  (:action simple-note-show-note
    ; API: simple_note.show_note
    :parameters (?n - note ?t - token)
    :precondition (and (not (task-completed)) (has-token simple-note ?t) (known-id ?n))
    :effect (shares-known))

  (:action venmo-login
    ; API: venmo.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw) (token-of venmo ?t)
                       (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  (:action venmo-show-transactions
    ; API: venmo.show_transactions
    :parameters (?t - token ?dir - direction ?since - date)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (current-datetime-known))
    :effect (transactions-checked))

  (:action venmo-create-payment-request
    ; API: venmo.create_payment_request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (coworkers-found) (coworker-email ?p ?e)
                       (shares-known) (share ?p ?amt)
                       (transactions-checked) (not (already-paid ?p))
                       (not (payment-request-sent ?p ?amt ?d)))
    :effect (payment-request-sent ?p ?amt ?d))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters ()
    :precondition (and
      (payment-request-sent coworker-5 share-coworker-5 work-dinner)
      (payment-request-sent coworker-6 share-coworker-6 work-dinner)
      (payment-request-sent coworker-7 share-coworker-7 work-dinner)
      (not (task-completed)))
    :effect (task-completed))
)
