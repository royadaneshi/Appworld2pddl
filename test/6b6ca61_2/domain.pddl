(define (domain appworld-6b6ca61-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount description privacy file flag - object
    debtor - person)
  (:constants supervisor file-system venmo splitwise - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (account-username ?u - username)
    (has-token ?a - app ?t - token)
    (recursive-flag ?f - flag)
    (directory-listed)
    (debt-list-file ?f - file)
    (csv-read)
    (debt-entry ?p - debtor ?e - email ?amt - amount ?d - description)
    (search-query ?p - debtor ?q - query)
    (venmo-status-known ?p - debtor)
    (has-venmo-account ?p - debtor)
    (public-privacy ?pr - privacy)
    (supervisor-email ?e - email)
    (receipt-of ?p - debtor ?f - file)
    (transaction-sent ?p - debtor)
    (expense-recorded ?p - debtor)
    (debt-settled ?p - debtor)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (account-username ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (account-username ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (account-username ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (has-token splitwise ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?r - flag)
    :precondition (and (has-token file-system ?t) (recursive-flag ?r) (not (task-completed)))
    :effect (directory-listed))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token)
    :precondition (and (has-token file-system ?t) (directory-listed) (debt-list-file ?f) (not (task-completed)))
    :effect (csv-read))

  ; API: venmo.search_users
  (:action venmo-search-users
    :parameters (?t - token ?q - query ?p - debtor)
    :precondition (and (has-token venmo ?t) (csv-read) (search-query ?p ?q) (not (task-completed)))
    :effect (venmo-status-known ?p))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?pr - privacy ?p - debtor)
    :precondition (and (has-token venmo ?t) (venmo-status-known ?p) (has-venmo-account ?p) (debt-entry ?p ?e ?amt ?d) (public-privacy ?pr) (not (debt-settled ?p)) (not (task-completed)))
    :effect (and (transaction-sent ?p) (debt-settled ?p)))

  ; API: splitwise.record_expense
  (:action splitwise-record-expense
    :parameters (?d - description ?amt - amount ?payer-email - email ?debtor-email - email ?t - token ?receipt - file ?fst - token ?p - debtor)
    :precondition (and (has-token splitwise ?t) (has-token file-system ?fst) (directory-listed) (venmo-status-known ?p) (not (has-venmo-account ?p)) (debt-entry ?p ?payer-email ?amt ?d) (supervisor-email ?debtor-email) (receipt-of ?p ?receipt) (not (debt-settled ?p)) (not (task-completed)))
    :effect (and (expense-recorded ?p) (debt-settled ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - debtor ?p2 - debtor ?p3 - debtor)
    :precondition (and (debt-settled ?p1) (debt-settled ?p2) (debt-settled ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (task-completed))
)
