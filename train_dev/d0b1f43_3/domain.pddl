(define (domain appworld-d0b1f43-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship date amount - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (task-completed)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (query-for ?q - query ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (threshold-date ?d - date)
    (transactions-sum ?p - person ?a - amount)
    (found-total ?a - amount))

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
    :parameters (?t - token ?q - query ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?q ?r) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - date ?p - person ?a - amount)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (threshold-date ?d) (current-date-known) (transactions-sum ?p ?a) (not (task-completed)))
    :effect (found-total ?a))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - amount)
    :precondition (and (found-total ?ans) (not (task-completed)))
    :effect (task-completed))
)
