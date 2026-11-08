(define (domain appworld-fdc4b74-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token draft body query product price - object
  )
  (:constants supervisor gmail amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (draft-to ?d - draft ?p - person)
    (draft-matches ?d - draft ?q - query)
    (known-id ?d - draft)
    (draft-body-read ?d - draft)
    (lists-product ?d - draft ?pr - product)
    (product-query ?pr - product ?q - query)
    (price-of ?pr - product ?p - price)
    (price-cursor ?d - draft ?pr - product)
    (next-product ?pr - product ?next - product)
    (end-of-list ?pr - product)
    (found-price ?pr - product ?p - price)
    (body-for ?b - body ?d - draft)
    (prices-filled ?d - draft)
    (email-sent ?d - draft)
    (draft-deleted ?d - draft)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (passwords-known)
      (password-for gmail ?pw)
      (not (has-token gmail ?t))
    )
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_drafts
  (:action gmail-show-drafts
    :parameters (?t - token ?q - query ?d - draft)
    :precondition (and
      (not (task-completed))
      (has-token gmail ?t)
      (draft-matches ?d ?q)
    )
    :effect (known-id ?d)
  )

  ; API: gmail.show_draft
  (:action gmail-show-draft
    :parameters (?d - draft ?t - token)
    :precondition (and
      (not (task-completed))
      (has-token gmail ?t)
      (known-id ?d)
    )
    :effect (draft-body-read ?d)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pr - product ?p - price ?d - draft ?next - product)
    :precondition (and
      (not (task-completed))
      (draft-body-read ?d)
      (lists-product ?d ?pr)
      (price-cursor ?d ?pr)
      (product-query ?pr ?q)
      (price-of ?pr ?p)
      (next-product ?pr ?next)
    )
    :effect (and
      (found-price ?pr ?p)
      (not (price-cursor ?d ?pr))
      (price-cursor ?d ?next)
    )
  )

  ; API: gmail.update_draft
  (:action gmail-update-draft
    :parameters (?d - draft ?t - token ?b - body ?end - product)
    :precondition (and
      (not (task-completed))
      (has-token gmail ?t)
      (known-id ?d)
      (draft-body-read ?d)
      (body-for ?b ?d)
      (price-cursor ?d ?end)
      (end-of-list ?end)
      (not (draft-deleted ?d))
    )
    :effect (prices-filled ?d)
  )

  ; API: gmail.send_email_from_draft
  (:action gmail-send-email-from-draft
    :parameters (?d - draft ?t - token)
    :precondition (and
      (not (task-completed))
      (has-token gmail ?t)
      (known-id ?d)
      (prices-filled ?d)
      (not (draft-deleted ?d))
    )
    :effect (and
      (email-sent ?d)
      (draft-deleted ?d)
    )
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?d - draft)
    :precondition (and
      (not (task-completed))
      (prices-filled ?d)
      (email-sent ?d)
      (draft-deleted ?d)
    )
    :effect (task-completed)
  )
)
