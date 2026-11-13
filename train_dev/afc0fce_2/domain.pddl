(define (domain appworld-afc0fce-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship date direction transaction comment - object
  )
  (:constants
    phone venmo - app
    tx-8280 tx-8281 tx-8282 tx-8283 tx-8284 tx-8285 tx-8286 tx-8287 tx-8288 tx-8295 tx-8297 tx-8298 - transaction
    comment-thanks - comment
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (profile-known)
    (passwords-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (friends-found)
    (friend-email ?p - person ?e - email)
    (window-start ?d - date)
    (transactions-found ?p - person)
    (received-from ?txn - transaction ?p - person)
    (liked ?txn - transaction)
    (commented ?txn - transaction ?c - comment)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (friends-found))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - date ?dir - direction ?p - person)
    :precondition (and (has-token venmo ?t) (friends-found) (friend-email ?p ?e)
                       (current-date-known) (window-start ?d) (not (task-completed)))
    :effect (and (transactions-found ?p))
  )

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?txn - transaction ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-found ?p) (received-from ?txn ?p)
                       (not (liked ?txn)) (not (task-completed)))
    :effect (and (liked ?txn))
  )

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?txn - transaction ?c - comment ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-found ?p) (received-from ?txn ?p)
                       (not (commented ?txn ?c)) (not (task-completed)))
    :effect (and (commented ?txn ?c))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (liked tx-8280)
      (liked tx-8281)
      (liked tx-8282)
      (liked tx-8283)
      (liked tx-8284)
      (liked tx-8285)
      (liked tx-8286)
      (liked tx-8287)
      (liked tx-8288)
      (liked tx-8295)
      (liked tx-8297)
      (liked tx-8298)
      (commented tx-8280 comment-thanks)
      (commented tx-8281 comment-thanks)
      (commented tx-8282 comment-thanks)
      (commented tx-8283 comment-thanks)
      (commented tx-8284 comment-thanks)
      (commented tx-8285 comment-thanks)
      (commented tx-8286 comment-thanks)
      (commented tx-8287 comment-thanks)
      (commented tx-8288 comment-thanks)
      (commented tx-8295 comment-thanks)
      (commented tx-8297 comment-thanks)
      (commented tx-8298 comment-thanks)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
