(define (domain appworld-d0b1f43-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query relationship email date direction amount - object)
  (:constants phone venmo - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-date-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (contact-search ?q - query ?r - relationship ?p - person)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (target-group ?p - person)
    (threshold-date ?d - date)
    (target-direction ?dir - direction)
    (total-for ?p - person ?amt - amount)
    (answer-found ?amt - amount)
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
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-search ?q ?r ?p) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - date ?dir - direction ?p - person ?amt - amount)
    :precondition (and (has-token venmo ?t) (target-group ?p) (known-email ?p ?e) (current-date-known) (threshold-date ?d) (target-direction ?dir) (total-for ?p ?amt) (not (task-completed)))
    :effect (and (answer-found ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (answer-found ?amt) (not (task-completed)))
    :effect (and (task-completed)))
)
