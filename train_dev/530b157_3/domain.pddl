(define (domain appworld-530b157-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number query amount description message - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (datetime-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (phone-of ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (owes ?p - person ?amt - amount)
    (found-owed-amount ?p - person ?amt - amount)
    (transaction-sent ?p - person ?amt - amount ?d - description)
    (paid ?p - person)
    (text-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (datetime-known)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email ?n - phone-number)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (email-of ?p ?e) (phone-of ?p ?n) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-phone ?p ?n)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?amt - amount)
    :precondition (and (has-token phone ?t) (datetime-known) (known-phone ?p ?n) (owes ?p ?amt) (not (task-completed)))
    :effect (and (found-owed-amount ?p ?amt)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-owed-amount ?p ?amt) (not (paid ?p)) (not (task-completed)))
    :effect (and (transaction-sent ?p ?amt ?d) (paid ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (paid ?p) (not (text-sent ?p ?m)) (not (task-completed)))
    :effect (and (text-sent ?p ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount ?d - description ?m - message)
    :precondition (and (transaction-sent ?p ?amt ?d) (text-sent ?p ?m) (not (task-completed)))
    :effect (and (task-completed)))
)
