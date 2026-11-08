(define (domain appworld-fdc4b74-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query draft item body count - object)
  (:constants supervisor gmail amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (draft-matches ?q - query ?d - draft)
    (draft-recipient ?d - draft ?p - person)
    (known-id ?d - draft)
    (draft-read ?d - draft)
    (item-in-draft ?d - draft ?i - item)
    (item-query ?i - item ?q - query)
    (price-known ?i - item)
    (prices-found ?n - count)
    (succ ?n - count ?m - count)
    (num-items ?n - count)
    (body-for ?b - body ?d - draft)
    (draft-updated ?d - draft)
    (email-sent ?d - draft)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and (has-token gmail ?t) (draft-matches ?q ?d) (not (task-completed)))
    :effect (and (known-id ?d)))

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (known-id ?d) (has-token gmail ?t) (not (task-completed)))
    :effect (and (draft-read ?d)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?i - item ?d - draft ?n - count ?m - count)
    :precondition (and (item-in-draft ?d ?i) (draft-read ?d) (item-query ?i ?q) (not (price-known ?i)) (prices-found ?n) (succ ?n ?m) (not (task-completed)))
    :effect (and (price-known ?i) (not (prices-found ?n)) (prices-found ?m)))

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body ?n - count)
    :precondition (and (known-id ?d) (draft-read ?d) (has-token gmail ?t) (body-for ?b ?d) (prices-found ?n) (num-items ?n) (not (task-completed)))
    :effect (and (draft-updated ?d)))

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and (known-id ?d) (draft-updated ?d) (has-token gmail ?t) (not (task-completed)))
    :effect (and (email-sent ?d)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft)
    :precondition (and (draft-updated ?d) (email-sent ?d) (not (task-completed)))
    :effect (and (task-completed))))
