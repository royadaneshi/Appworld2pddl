(define (domain appworld-6ea6792-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship status payment-request count - object)
  (:constants
    supervisor phone venmo - app
    count-0 - count)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?r - relationship)
    (contact-relation ?p - person ?r - relationship)
    (relation-searched ?r - relationship)
    (pending-status ?s - status)
    (requests-listed)
    (request-from ?pr - payment-request ?p - person)
    (pending ?pr - payment-request)
    (denied ?pr - payment-request)
    (remaining ?c - count)
    (next-count ?c1 - count ?c2 - count)
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

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?q ?r) (not (task-completed)))
    :effect (relation-searched ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (pending-status ?s) (not (task-completed)))
    :effect (requests-listed))

  ; API: venmo.deny_payment_request
  (:action venmo-deny-payment-request
    :parameters (?pr - payment-request ?t - token ?p - person ?r - relationship ?c - count ?c2 - count)
    :precondition (and (has-token venmo ?t) (requests-listed) (pending ?pr) (not (denied ?pr)) (request-from ?pr ?p) (contact-relation ?p ?r) (relation-searched ?r) (remaining ?c) (next-count ?c ?c2) (not (task-completed)))
    :effect (and (denied ?pr) (not (pending ?pr)) (not (remaining ?c)) (remaining ?c2)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (remaining count-0) (not (task-completed)))
    :effect (task-completed))
)
