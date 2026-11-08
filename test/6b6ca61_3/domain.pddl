(define (domain appworld-6b6ca61-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount description privacy path dirpath flag - object
  )
  (:constants file-system venmo splitwise - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (home-directory ?d - dirpath)
    (flag-true ?r - flag)
    (files-located)
    (csv-file ?f - path)
    (csv-read)
    (person-email ?p - person ?e - email)
    (supervisor-email ?e - email)
    (owes ?p - person ?amt - amount ?desc - description)
    (receipt-for ?p - person ?f - path)
    (privacy-private ?pr - privacy)
    (has-venmo-account ?p - person)
    (venmo-status-known ?p - person)
    (debt-settled ?p - person)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath ?r - flag)
    :precondition (and (has-token file-system ?t) (home-directory ?d) (flag-true ?r) (not (task-completed)))
    :effect (and (files-located))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - path ?t - token)
    :precondition (and (has-token file-system ?t) (files-located) (csv-file ?f) (not (task-completed)))
    :effect (and (csv-read))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (and (has-token splitwise ?t))
  )

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?q - email ?p - person)
    :precondition (and (has-token venmo ?t) (csv-read) (person-email ?p ?q) (not (task-completed)))
    :effect (and (venmo-status-known ?p))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?desc - description ?pr - privacy ?p - person)
    :precondition (and (has-token venmo ?t) (csv-read) (venmo-status-known ?p) (has-venmo-account ?p) (person-email ?p ?e) (owes ?p ?amt ?desc) (privacy-private ?pr) (not (debt-settled ?p)) (not (task-completed)))
    :effect (and (debt-settled ?p))
  )

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?desc - description ?amt - amount ?payer - email ?debtor - email ?t - token ?share - amount ?f - path ?fst - token ?p - person)
    :precondition (and (has-token splitwise ?t) (has-token file-system ?fst) (csv-read) (files-located) (venmo-status-known ?p) (not (has-venmo-account ?p)) (person-email ?p ?payer) (supervisor-email ?debtor) (owes ?p ?amt ?desc) (= ?share ?amt) (receipt-for ?p ?f) (not (debt-settled ?p)) (not (task-completed)))
    :effect (and (debt-settled ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person)
    :precondition (and (debt-settled ?p1) (debt-settled ?p2) (debt-settled ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
