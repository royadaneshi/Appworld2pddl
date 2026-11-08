(define (domain appworld-d037dc8-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email amount note relationship order count - object)
  (:constants supervisor amazon phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (orders-listed)
    (recent-order ?o - order)
    (order-total-known ?o - order)
    (totals-known-count ?c - count)
    (succ ?c1 - count ?c2 - count)
    (num-recent-orders ?c - count)
    (contacts-searched)
    (roommate-relationship ?r - relationship)
    (is-roommate ?p - person)
    (contact-email ?p - person ?e - email)
    (share-amount ?amt - amount)
    (request-note ?n - note)
    (request-sent ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (orders-listed)))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?c1 - count ?c2 - count)
    :precondition (and (has-token amazon ?t) (orders-listed) (recent-order ?o) (not (order-total-known ?o)) (totals-known-count ?c1) (succ ?c1 ?c2) (not (task-completed)))
    :effect (and (order-total-known ?o) (not (totals-known-count ?c1)) (totals-known-count ?c2)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (roommate-relationship ?r) (not (task-completed)))
    :effect (and (contacts-searched)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?c - count)
    :precondition (and (has-token venmo ?t) (contacts-searched) (totals-known-count ?c) (num-recent-orders ?c) (is-roommate ?p) (contact-email ?p ?e) (share-amount ?amt) (request-note ?n) (not (request-sent ?p)) (not (task-completed)))
    :effect (and (request-sent ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person)
    :precondition (and (is-roommate ?p1) (is-roommate ?p2) (is-roommate ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (request-sent ?p1) (request-sent ?p2) (request-sent ?p3) (not (task-completed)))
    :effect (and (task-completed)))
)
