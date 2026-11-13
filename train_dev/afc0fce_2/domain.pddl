(define (domain appworld-afc0fce-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship date direction transaction comment - object
  )
  (:constants
    phone venmo - app
    txn-1 txn-2 txn-3 txn-4 txn-5 txn-6 txn-7 txn-8 txn-9 txn-10 txn-11 txn-12 - transaction
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
      (liked txn-1)
      (liked txn-2)
      (liked txn-3)
      (liked txn-4)
      (liked txn-5)
      (liked txn-6)
      (liked txn-7)
      (liked txn-8)
      (liked txn-9)
      (liked txn-10)
      (liked txn-11)
      (liked txn-12)
      (commented txn-1 comment-thanks)
      (commented txn-2 comment-thanks)
      (commented txn-3 comment-thanks)
      (commented txn-4 comment-thanks)
      (commented txn-5 comment-thanks)
      (commented txn-6 comment-thanks)
      (commented txn-7 comment-thanks)
      (commented txn-8 comment-thanks)
      (commented txn-9 comment-thanks)
      (commented txn-10 comment-thanks)
      (commented txn-11 comment-thanks)
      (commented txn-12 comment-thanks)
      (not (task-completed)))
    :effect (and (task-completed))
  )
)
