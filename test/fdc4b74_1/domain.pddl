(define (domain appworld-fdc4b74-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query body entity - object
    draft product - entity)
  (:constants supervisor gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (logged-in ?a - app)
    (known-id ?x - entity)
    (draft-query ?d - draft ?q - query)
    (draft-read ?d - draft)
    (listed-in ?p - product ?d - draft)
    (product-query ?p - product ?q - query)
    (found-price ?p - product)
    (body-of ?b - body ?d - draft)
    (draft-updated ?d - draft)
    (email-sent ?d - draft)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t) (logged-in gmail)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t) (logged-in amazon)))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-query ?d ?q) (not (task-completed)))
    :effect (known-id ?d))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (known-id ?d) (not (task-completed)))
    :effect (draft-read ?d))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product ?d - draft)
    :precondition (and (logged-in amazon) (product-query ?p ?q) (listed-in ?p ?d) (draft-read ?d) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (logged-in amazon) (known-id ?p) (not (task-completed)))
    :effect (found-price ?p))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body ?p1 - product ?p2 - product ?p3 - product)
    :precondition (and (has-token gmail ?t) (draft-read ?d) (body-of ?b ?d)
                       (listed-in ?p1 ?d) (listed-in ?p2 ?d) (listed-in ?p3 ?d)
                       (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3))
                       (found-price ?p1) (found-price ?p2) (found-price ?p3)
                       (not (task-completed)))
    :effect (draft-updated ?d))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (has-token gmail ?t) (draft-updated ?d) (not (task-completed)))
    :effect (email-sent ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft)
    :precondition (and (email-sent ?d) (not (task-completed)))
    :effect (task-completed)))
