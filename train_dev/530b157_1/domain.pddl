(define (domain appworld-530b157-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number query amount note message transaction text-message - object
  )
  (:constants venmo phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?p - person ?q - query)
    (known-email ?p - person ?e - email)
    (known-phone ?p - person ?ph - phone-number)
    (found-owed-amount ?p - person ?amt - amount)
    (transaction-spec ?tx - transaction ?p - person ?amt - amount ?d - note)
    (text-spec ?tm - text-message ?p - person ?m - message)
    (transaction-sent ?tx - transaction)
    (money-sent ?p - person)
    (text-sent ?tm - text-message)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email ?ph - phone-number)
    :precondition (and (not (task-completed)) (has-token phone ?t) (query-for ?p ?q))
    :effect (and (known-email ?p ?e) (known-phone ?p ?ph))
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?ph - phone-number ?p - person ?amt - amount)
    :precondition (and (not (task-completed)) (has-token phone ?t) (known-phone ?p ?ph) (date-known))
    :effect (and (found-owed-amount ?p ?amt))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - note ?p - person ?tx - transaction)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (found-owed-amount ?p ?amt) (transaction-spec ?tx ?p ?amt ?d) (not (transaction-sent ?tx)))
    :effect (and (transaction-sent ?tx) (money-sent ?p))
  )

  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?ph - phone-number ?m - message ?t - token ?p - person ?tm - text-message)
    :precondition (and (not (task-completed)) (has-token phone ?t) (known-phone ?p ?ph) (money-sent ?p) (text-spec ?tm ?p ?m) (not (text-sent ?tm)))
    :effect (and (text-sent ?tm))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction ?tm - text-message)
    :precondition (and (not (task-completed)) (transaction-sent ?tx) (text-sent ?tm))
    :effect (and (task-completed))
  )
)
