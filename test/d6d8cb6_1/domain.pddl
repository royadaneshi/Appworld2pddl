(define (domain appworld-d6d8cb6-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query - object
    order product deliverer quantity - object
    email email-thread email-message - object)
  (:constants amazon gmail phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (order-query ?q - query ?o - order)
    (order-found ?o - order)
    (order-contains ?o - order ?p - product)
    (order-product-known ?o - order ?p - product)
    (deliverer-known ?d - deliverer)
    (return-initiated ?o - order ?p - product ?d - deliverer ?q - quantity)
    (return-confirmation-emailed ?o - order)
    (confirmation-thread-of ?o - order ?th - email-thread)
    (thread-query ?q - query ?th - email-thread)
    (thread-found ?th - email-thread)
    (thread-contains ?th - email-thread ?em - email-message)
    (email-found ?em - email-message ?th - email-thread)
    (contact-query ?q - query ?p - person)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (forwarded ?em - email-message ?e - email)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_orders
  (:action amazon-show-orders
    :parameters (?t - token ?q - query ?o - order)
    :precondition (and (has-token amazon ?t) (order-query ?q ?o) (not (task-completed)))
    :effect (order-found ?o))

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?p - product)
    :precondition (and (has-token amazon ?t) (order-found ?o) (order-contains ?o ?p) (not (task-completed)))
    :effect (order-product-known ?o ?p))

  ; API: amazon.show_return_deliverers
  (:action amazon-show-return-deliverers
    :parameters (?d - deliverer)
    :precondition (not (task-completed))
    :effect (deliverer-known ?d))

  ; API: amazon.initiate_return
  (:action amazon-initiate-return
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?t - token)
    :precondition (and (has-token amazon ?t) (order-product-known ?o ?p) (deliverer-known ?d) (not (return-initiated ?o ?p ?d ?q)) (not (task-completed)))
    :effect (and (return-initiated ?o ?p ?d ?q) (return-confirmation-emailed ?o)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?q ?p) (contact-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (thread-query ?q ?th) (confirmation-thread-of ?o ?th) (return-confirmation-emailed ?o) (not (task-completed)))
    :effect (thread-found ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?em - email-message)
    :precondition (and (has-token gmail ?t) (thread-found ?th) (thread-contains ?th ?em) (not (task-completed)))
    :effect (email-found ?em ?th))

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?em - email-message ?e - email ?t - token ?p - person)
    :precondition (and (has-token gmail ?t) (email-found ?em ?th) (known-email ?p ?e) (not (task-completed)))
    :effect (forwarded ?em ?e))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?d - deliverer ?q - quantity ?em - email-message ?e - email)
    :precondition (and (return-initiated ?o ?p ?d ?q) (forwarded ?em ?e) (not (task-completed)))
    :effect (task-completed))
)
