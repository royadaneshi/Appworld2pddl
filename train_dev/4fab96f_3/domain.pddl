(define (domain appworld-4fab96f-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship status payment-request - object
  )
  (:constants
    phone venmo - app
    request-1608 request-1627 request-1615 request-1613 request-1612 request-1624 - payment-request
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (current-date-known)
    (roommate-relationship ?rel - relationship)
    (search-query-for ?q - query ?rel - relationship)
    (roommate ?p - person)
    (roommates-found)
    (pending-status ?s - status)
    (pending ?r - payment-request)
    (sent-to ?r - payment-request ?p - person)
    (at-least-50-days-old ?r - payment-request)
    (pending-requests-found)
    (reminded ?r - payment-request)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?rel - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?rel) (search-query-for ?q ?rel) (not (task-completed)))
    :effect (and (roommates-found))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (pending-status ?s) (not (task-completed)))
    :effect (and (pending-requests-found))
  )

  ; API: venmo.remind_payment_request
  (:action venmo-remind-payment-request
    :parameters (?r - payment-request ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (roommates-found) (pending-requests-found) (current-date-known) (sent-to ?r ?p) (roommate ?p) (pending ?r) (at-least-50-days-old ?r) (not (reminded ?r)) (not (task-completed)))
    :effect (and (reminded ?r))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (reminded request-1608)
      (reminded request-1627)
      (reminded request-1615)
      (reminded request-1613)
      (reminded request-1612)
      (reminded request-1624)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
