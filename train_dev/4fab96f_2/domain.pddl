(define (domain appworld-4fab96f-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship status payment-request - object)
  (:constants
    phone venmo - app
    request-4575 request-4580 request-4583 request-4512 request-4571 request-4576 request-4511 request-4509 request-4531 request-4581 request-4562 request-4515 request-4518 request-4561 request-4565 request-4559 - payment-request)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (current-date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (coworker-query ?q - query)
    (coworker-relationship ?rel - relationship)
    (pending-filter ?s - status)
    (coworker ?p - person)
    (coworkers-found)
    (requests-listed)
    (request-to ?r - payment-request ?p - person)
    (request-pending ?r - payment-request)
    (request-at-least-40-days-old ?r - payment-request)
    (reminded ?r - payment-request)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (coworker-query ?q) (coworker-relationship ?rel))
    :effect (and (coworkers-found)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_sent_payment_requests
  (:action venmo-show-sent-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (pending-filter ?s))
    :effect (and (requests-listed)))

  ; API: venmo.remind_payment_request
  (:action venmo-remind-payment-request
    :parameters (?r - payment-request ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (requests-listed) (coworkers-found) (current-date-known)
                       (request-to ?r ?p) (coworker ?p)
                       (request-pending ?r) (request-at-least-40-days-old ?r)
                       (not (reminded ?r)))
    :effect (and (reminded ?r)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (reminded request-4575)
      (reminded request-4580)
      (reminded request-4583)
      (reminded request-4512)
      (reminded request-4571)
      (reminded request-4576)
      (reminded request-4511)
      (reminded request-4509)
      (reminded request-4531)
      (reminded request-4581)
      (reminded request-4562)
      (reminded request-4515)
      (reminded request-4518)
      (reminded request-4561)
      (reminded request-4565)
      (reminded request-4559)
      (not (task-completed)))
    :effect (and (task-completed)))
)
