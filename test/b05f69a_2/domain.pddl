(define (domain appworld-b05f69a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token order file-path dir-path flag - object)
  (:constants amazon file-system - app order-1 order-2 order-3 - order)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (supervisor-order ?o - order)
    (receipt-path ?o - order ?p - file-path)
    (path-in-directory ?p - file-path ?d - dir-path)
    (target-directory ?d - dir-path)
    (directory-created ?d - dir-path)
    (receipt-downloaded ?o - order)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (orders-listed))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dir-path ?t - token ?recursive - flag)
    :precondition (and (has-token file-system ?t) (target-directory ?d) (not (directory-created ?d)) (not (task-completed)))
    :effect (directory-created ?d))

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?p - file-path ?ft - token ?d - dir-path)
    :precondition (and (has-token amazon ?t) (has-token file-system ?ft) (orders-listed) (supervisor-order ?o) (receipt-path ?o ?p) (path-in-directory ?p ?d) (directory-created ?d) (not (receipt-downloaded ?o)) (not (task-completed)))
    :effect (receipt-downloaded ?o))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (receipt-downloaded order-1) (receipt-downloaded order-2) (receipt-downloaded order-3) (not (task-completed)))
    :effect (task-completed))
)
