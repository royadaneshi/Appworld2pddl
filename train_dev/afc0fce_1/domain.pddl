(define (domain appworld-afc0fce-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship email date direction comment-text transaction - object
  )
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (search-query ?r - relationship ?q - query)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (contacts-searched ?r - relationship)
    (threshold-date ?d - date)
    (direction-received ?dir - direction)
    (comment-to-post ?c - comment-text)
    (recent-payment-from ?tx - transaction ?e - email)
    (transactions-listed ?e - email)
    (liked ?tx - transaction)
    (commented ?tx - transaction ?c - comment-text)
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
    :effect (and (current-date-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (search-query ?r ?q) (not (task-completed)))
    :effect (and (contacts-searched ?r))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - date ?dir - direction ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (current-date-known) (threshold-date ?d) (direction-received ?dir) (contacts-searched ?r) (has-relationship ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (and (transactions-listed ?e))
  )

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?tx - transaction ?t - token ?e - email)
    :precondition (and (has-token venmo ?t) (transactions-listed ?e) (recent-payment-from ?tx ?e) (not (liked ?tx)) (not (task-completed)))
    :effect (and (liked ?tx))
  )

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?tx - transaction ?c - comment-text ?t - token ?e - email)
    :precondition (and (has-token venmo ?t) (comment-to-post ?c) (transactions-listed ?e) (recent-payment-from ?tx ?e) (not (commented ?tx ?c)) (not (task-completed)))
    :effect (and (commented ?tx ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed))
  )
)
