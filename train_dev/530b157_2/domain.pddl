(define (domain appworld-530b157-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number query amount description message - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-datetime-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-matches ?q - query ?p - person)
    (contact-email ?p - person ?e - email)
    (contact-phone ?p - person ?ph - phone-number)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (owed-amount ?p - person ?amt - amount)
    (found-owed-amount ?p - person ?amt - amount)
    (payment-made ?p - person)
    (money-sent ?p - person ?amt - amount ?d - description)
    (text-sent ?p - person ?m - message)
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
    :precondition (and (passwords-known) (profile-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email ?ph - phone-number)
    :precondition (and (has-token phone ?t) (query-matches ?q ?p) (contact-email ?p ?e) (contact-phone ?p ?ph) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-phone ?p ?ph)))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?ph - phone-number ?p - person ?amt - amount)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (current-datetime-known) (owed-amount ?p ?amt) (not (task-completed)))
    :effect (found-owed-amount ?p ?amt))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (profile-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (found-owed-amount ?p ?amt) (not (payment-made ?p)) (not (task-completed)))
    :effect (and (money-sent ?p ?amt ?d) (payment-made ?p)))

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?ph) (payment-made ?p) (not (task-completed)))
    :effect (text-sent ?p ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount ?d - description ?m - message)
    :precondition (and (money-sent ?p ?amt ?d) (text-sent ?p ?m) (not (task-completed)))
    :effect (task-completed))
)
