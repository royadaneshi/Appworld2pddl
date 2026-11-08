(define (problem task-8ce6779-2)
  (:domain appworld-8ce6779-2)
  (:objects
    paul-miller - person
    paul-mill-username - username
    todoist-password - password
    todoist-token - token
    paul-mill-at-gmail-com volunteer-1-email volunteer-2-email - email
    flag-false - flag
    work-project - project)
  (:init
    (password-for todoist todoist-password)
    (supervisor-email paul-mill-at-gmail-com)
    (person-email paul-miller paul-mill-at-gmail-com)
    (task-in-project task-1 work-project)
    (task-in-project task-2 work-project)
    (assigned-to-me task-1)
    (incomplete task-1)
    (assigned-to-me task-2)
    (incomplete task-2)
    (volunteer task-1 volunteer-1)
    (volunteer task-2 volunteer-2)
    (person-email volunteer-1 volunteer-1-email)
    (person-email volunteer-2 volunteer-2-email)
    (thanks-message volunteer-1 thanks-volunteer-1)
    (thanks-message volunteer-2 thanks-volunteer-2))
  (:goal (and
    (reassigned task-1 volunteer-1)
    (comment-posted task-1 thanks-volunteer-1)
    (reassigned task-2 volunteer-2)
    (comment-posted task-2 thanks-volunteer-2)
    (task-completed))))
