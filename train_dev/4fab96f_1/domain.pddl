(define (domain appworld-4fab96f-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship status payment-request - object
  )
  (:constants
    phone venmo - app
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (current-datetime-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (roommates-known)
    (sent-requests-known)
    (is-roommate ?p - person)
    (request-to ?pr - payment-request ?p - person)
    (pending ?pr - payment-request)
    (at-least-30-days-old ?pr - payment-request)
    (reminded ?pr - payment-request)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-datetime-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw)
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (username-for phone ?u)
      (password-for phone ?pw)
      (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and
      (not (task-completed))
      (has-token phone ?t))
    :effect (and (roommates-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw)
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (username-for venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and
      (not (task-completed))
      (has-token venmo ?t))
    :effect (and (sent-requests-known))
  )

  ; API: venmo.remind_payment_request
  (:action venmo-remind-payment-request
    :parameters (?pr - payment-request ?t - token ?p - person)
    :precondition (and
      (not (task-completed))
      (has-token venmo ?t)
      (roommates-known)
      (sent-requests-known)
      (current-datetime-known)
      (request-to ?pr ?p)
      (is-roommate ?p)
      (pending ?pr)
      (at-least-30-days-old ?pr)
      (not (reminded ?pr)))
    :effect (and (reminded ?pr))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
