(define (domain appworld-d0b1f43-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime direction amount - object)
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (profile-known)
    (passwords-known)
    (current-date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (relationship-query ?q - query ?r - relationship)
    (contact-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (threshold-date ?d - datetime)
    (sent-direction ?dir - direction)
    (answer-known ?a - amount)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (relationship-query ?q ?r) (contact-relationship ?p ?r) (contact-email ?p ?e))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - datetime ?dir - direction ?p - person ?a - amount)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (current-date-known) (threshold-date ?d) (sent-direction ?dir))
    :effect (and (answer-known ?a)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?a - amount)
    :precondition (and (answer-known ?a) (not (task-completed)))
    :effect (and (task-completed)))
)
