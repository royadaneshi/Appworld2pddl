(define (domain appworld-b05f69a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-msg attachment order file-path - object)
  (:constants supervisor gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (confirmation-query ?q - query)
    (confirmation-emails-found)
    (confirmation-email-of ?e - email-msg ?o - order)
    (receipt-attachment-of ?att - attachment ?o - order)
    (receipt-path-for ?p - file-path ?o - order)
    (order-details-known ?o - order)
    (receipt-saved ?o - order)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)))
    :effect (has-token file-system ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (confirmation-query ?q))
    :effect (confirmation-emails-found))

  ; API: gmail.show_email
  (:action gmail-show-email
    :parameters (?e - email-msg ?t - token ?o - order)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (confirmation-emails-found) (confirmation-email-of ?e ?o))
    :effect (order-details-known ?o))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?fst - token ?t - token ?p - file-path ?o - order)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (has-token file-system ?fst) (order-details-known ?o) (receipt-attachment-of ?att ?o) (receipt-path-for ?p ?o) (not (receipt-saved ?o)))
    :effect (receipt-saved ?o))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 - order ?o2 - order)
    :precondition (and (not (task-completed)) (not (= ?o1 ?o2)) (receipt-saved ?o1) (receipt-saved ?o2))
    :effect (task-completed))
)
