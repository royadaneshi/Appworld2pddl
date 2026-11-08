(define (domain appworld-b05f69a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token order filepath dirpath - object)
  (:constants amazon file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (receipt-path ?o - order ?p - filepath)
    (in-directory ?p - filepath ?d - dirpath)
    (directory-created ?d - dirpath)
    (receipt-downloaded ?o - order)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (orders-listed)) (not (task-completed)))
    :effect (and (orders-listed)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dirpath ?t - token)
    :precondition (and (has-token file-system ?t) (not (directory-created ?d)) (not (task-completed)))
    :effect (and (directory-created ?d)))

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?p - filepath ?ft - token ?d - dirpath)
    :precondition (and (has-token amazon ?t) (has-token file-system ?ft) (orders-listed) (receipt-path ?o ?p) (in-directory ?p ?d) (directory-created ?d) (not (receipt-downloaded ?o)) (not (task-completed)))
    :effect (and (receipt-downloaded ?o)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o1 ?o2 ?o3 - order)
    :precondition (and (receipt-downloaded ?o1) (receipt-downloaded ?o2) (receipt-downloaded ?o3) (not (= ?o1 ?o2)) (not (= ?o1 ?o3)) (not (= ?o2 ?o3)) (not (task-completed)))
    :effect (and (task-completed)))
)
