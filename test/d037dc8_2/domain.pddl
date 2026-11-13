(define (domain appworld-d037dc8-2)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token email order amount note relationship - object)
  (:constants supervisor amazon phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (recent-order ?o - order)
    (orders-listed)
    (order-cost-known ?o - order)
    (share-of ?o1 - order ?o2 - order ?o3 - order ?amt - amount)
    (roommate-relationship ?rel - relationship)
    (roommates-found)
    (is-roommate ?p - person)
    (email-of ?p - person ?e - email)
    (request-note ?n - note)
    (request-sent ?p - person ?amt - amount ?n - note)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)) (not (passwords-known)))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for amazon ?u) (password-for amazon ?pw)
                       (token-for amazon ?t) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (orders-listed)))
    :effect (orders-listed))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (orders-listed)
                       (recent-order ?o) (not (order-cost-known ?o)))
    :effect (order-cost-known ?o))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (roommate-relationship ?rel) (not (roommates-found)))
    :effect (roommates-found))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note
                 ?p - person ?o1 - order ?o2 - order ?o3 - order)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (roommates-found) (is-roommate ?p) (email-of ?p ?e)
                       (request-note ?n)
                       (share-of ?o1 ?o2 ?o3 ?amt)
                       (order-cost-known ?o1) (order-cost-known ?o2) (order-cost-known ?o3)
                       (not (request-sent ?p ?amt ?n)))
    :effect (request-sent ?p ?amt ?n))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount ?n - note)
    :precondition (and (request-note ?n) (forall (?p - person) (imply (is-roommate ?p) (request-sent ?p ?amt ?n))) (not (task-completed)))
    :effect (task-completed))

)
