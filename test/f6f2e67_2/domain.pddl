(define (domain appworld-f6f2e67-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship
    email-thread attachment path subject body - object)
  (:constants supervisor phone gmail file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (relationship-of ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (is-parent ?p - person)
    (thread-from ?th - email-thread ?p - person)
    (known-thread ?th - email-thread)
    (attachment-in-thread ?att - attachment ?th - email-thread)
    (known-attachment ?att - attachment)
    (download-target ?f - path)
    (downloaded ?att - attachment ?f - path)
    (work-dir ?d - path)
    (my-photos-dir ?d - path)
    (subdirectory-of ?sub - path ?d - path)
    (dir-has-sister-photos ?d - path)
    (dir-has-my-photos ?d - path)
    (tar-target ?f - path)
    (updated-tar ?f - path)
    (required-subject ?s - subject)
    (required-body ?b - body)
    (parents-emailed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?r) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?e - email ?p - person ?th - email-thread)
    :precondition (and (has-token gmail ?t) (known-email ?p ?e) (thread-from ?th ?p) (not (task-completed)))
    :effect (known-thread ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?att - attachment)
    :precondition (and (known-thread ?th) (has-token gmail ?t) (attachment-in-thread ?att ?th) (not (task-completed)))
    :effect (known-attachment ?att))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?ft - token ?t - token ?f - path)
    :precondition (and (known-attachment ?att) (has-token file-system ?ft) (has-token gmail ?t)
                       (download-target ?f) (not (task-completed)))
    :effect (downloaded ?att ?f))

  ; API: file_system.decompress_file
  (:action file-system-decompress-file
    :parameters (?f - path ?t - token ?d - path ?att - attachment)
    :precondition (and (downloaded ?att ?f) (has-token file-system ?t) (work-dir ?d) (not (task-completed)))
    :effect (dir-has-sister-photos ?d))

  ; API: file_system.copy_directory
  (:action file-system-copy-directory
    :parameters (?src - path ?dst - path ?t - token ?d - path)
    :precondition (and (my-photos-dir ?src) (subdirectory-of ?dst ?d) (dir-has-sister-photos ?d)
                       (has-token file-system ?t) (not (task-completed)))
    :effect (dir-has-my-photos ?d))

  ; API: file_system.compress_directory
  (:action file-system-compress-directory
    :parameters (?d - path ?t - token ?f - path)
    :precondition (and (dir-has-sister-photos ?d) (dir-has-my-photos ?d) (has-token file-system ?t)
                       (tar-target ?f) (not (task-completed)))
    :effect (updated-tar ?f))

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e1 - email ?e2 - email ?s - subject ?b - body ?t - token ?f - path ?ft - token ?p1 - person ?p2 - person)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft)
                       (is-parent ?p1) (is-parent ?p2) (not (= ?p1 ?p2))
                       (known-email ?p1 ?e1) (known-email ?p2 ?e2)
                       (required-subject ?s) (required-body ?b) (updated-tar ?f)
                       (not (task-completed)))
    :effect (parents-emailed))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (parents-emailed) (not (task-completed)))
    :effect (task-completed))
)
