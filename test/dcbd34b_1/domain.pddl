(define (domain appworld-dcbd34b-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query thread file-path content count - object)
  (:constants gmail file-system supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (coworker ?p - person)
    (expense-query ?q - query)
    (expense-threads-listed)
    (thread-from ?th - thread ?p - person)
    (found-expenses ?p - person)
    (succ ?n1 - count ?n2 - count)
    (collected-count ?n - count)
    (num-coworkers ?n - count)
    (headers-known ?f - file-path)
    (content-for ?c - content ?f - file-path)
    (file-updated ?f - file-path ?c - content)
    (task-completed)
    (expense-thread ?th - thread)
    (expenses-collected))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query)
    :precondition (and (has-token gmail ?t) (expense-query ?q) (not (task-completed)))
    :effect (and (expense-threads-listed)))

  ; API: gmail.show_thread  (one thread holds every coworker's reply)
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token)
    :precondition (and (has-token gmail ?t) (expense-threads-listed) (expense-thread ?th) (not (task-completed)))
    :effect (and (expenses-collected)))


  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (and (headers-known ?f)))

  ; API: file_system.update_file
  (:action file-system-update-file
    :parameters (?f - file-path ?c - content ?t - token)
    :precondition (and (has-token file-system ?t) (headers-known ?f) (content-for ?c ?f) (expenses-collected) (not (task-completed)))
    :effect (and (file-updated ?f ?c)))


  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - file-path ?c - content)
    :precondition (and (file-updated ?f ?c) (not (task-completed)))
    :effect (and (task-completed))))
