(define (domain appworld-0d8a4ee-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number query relationship message count - object
  )
  (:constants
    phone venmo - app
    count-0 - count
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (query-for ?r - relationship ?q - query)
    (email-of ?p - person ?e - email)
    (phone-of ?p - person ?n - phone-number)
    (contacts-searched ?r - relationship)
    (has-venmo-account ?p - person)
    (venmo-status-known ?p - person)
    (message-sent ?p - person ?m - message)
    (count-succ ?lo - count ?hi - count)
    (remaining ?c - count)
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
  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )
  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?r ?q) (not (task-completed)))
    :effect (and (contacts-searched ?r))
  )
  ; API: venmo.show_profile
  (:action venmo-show-profile
    :parameters (?t - token ?e - email ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (contacts-searched ?r) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (and (venmo-status-known ?p))
  )
  ; API: phone.send_text_message
  (:action phone-send-text-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?lo - count ?hi - count)
    :precondition (and (has-token phone ?t) (phone-of ?p ?n) (venmo-status-known ?p) (not (has-venmo-account ?p)) (not (message-sent ?p ?m)) (remaining ?hi) (count-succ ?lo ?hi) (not (task-completed)))
    :effect (and (message-sent ?p ?m) (not (remaining ?hi)) (remaining ?lo))
  )
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (remaining count-0) (not (task-completed)))
    :effect (and (task-completed))
  )
)
