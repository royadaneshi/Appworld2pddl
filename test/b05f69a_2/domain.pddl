(define (domain appworld-b05f69a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token order file-path dir-path flag - object)
  (:constants
    amazon file-system - app
    order-1 order-2 order-3 order-4 order-5 order-6 order-7 order-8 order-9 order-10 order-11 order-12 order-13 order-14 order-15 order-16 order-17 order-18 order-19 order-20 order-21 order-22 order-23 order-24 order-25 order-26 order-27 order-28 order-29 - order
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
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
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
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
    :precondition (and
      (receipt-downloaded order-1)
      (receipt-downloaded order-2)
      (receipt-downloaded order-3)
      (receipt-downloaded order-4)
      (receipt-downloaded order-5)
      (receipt-downloaded order-6)
      (receipt-downloaded order-7)
      (receipt-downloaded order-8)
      (receipt-downloaded order-9)
      (receipt-downloaded order-10)
      (receipt-downloaded order-11)
      (receipt-downloaded order-12)
      (receipt-downloaded order-13)
      (receipt-downloaded order-14)
      (receipt-downloaded order-15)
      (receipt-downloaded order-16)
      (receipt-downloaded order-17)
      (receipt-downloaded order-18)
      (receipt-downloaded order-19)
      (receipt-downloaded order-20)
      (receipt-downloaded order-21)
      (receipt-downloaded order-22)
      (receipt-downloaded order-23)
      (receipt-downloaded order-24)
      (receipt-downloaded order-25)
      (receipt-downloaded order-26)
      (receipt-downloaded order-27)
      (receipt-downloaded order-28)
      (receipt-downloaded order-29)
      (not (task-completed)))
    :effect (task-completed))
)
