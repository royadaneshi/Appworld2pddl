(define (problem task-8ce6779-2)
  (:domain appworld-8ce6779-2)
  (:objects
    paul-miller - person
    paul-mill-username - username
    todoist-password - password
    todoist-token - token
    paul-mill-at-gmail-com volunteer-email-1 volunteer-email-2 volunteer-email-3 volunteer-email-4 - email
    flag-false - flag
    work-project - project
  )
  (:init
    (password-for todoist todoist-password)
    (supervisor-email paul-mill-at-gmail-com)
    (person-email paul-miller paul-mill-at-gmail-com)
    (task-in-project task-1 work-project)
    (assigned-to-me task-1)
    (incomplete task-1)
    (volunteer task-1 volunteer-1)
    (person-email volunteer-1 volunteer-email-1)
    (thanks-message volunteer-1 thanks-volunteer-1)
    (task-in-project task-2 work-project)
    (assigned-to-me task-2)
    (incomplete task-2)
    (volunteer task-2 volunteer-2)
    (person-email volunteer-2 volunteer-email-2)
    (thanks-message volunteer-2 thanks-volunteer-2)
    (task-in-project task-3 work-project)
    (assigned-to-me task-3)
    (incomplete task-3)
    (volunteer task-3 volunteer-3)
    (person-email volunteer-3 volunteer-email-3)
    (thanks-message volunteer-3 thanks-volunteer-3)
    (task-in-project task-4 work-project)
    (assigned-to-me task-4)
    (incomplete task-4)
    (volunteer task-4 volunteer-4)
    (person-email volunteer-4 volunteer-email-4)
    (thanks-message volunteer-4 thanks-volunteer-4))
  (:goal (and
    (reassigned task-1 volunteer-1)
    (comment-posted task-1 thanks-volunteer-1)
    (reassigned task-2 volunteer-2)
    (comment-posted task-2 thanks-volunteer-2)
    (reassigned task-3 volunteer-3)
    (comment-posted task-3 thanks-volunteer-3)
    (reassigned task-4 volunteer-4)
    (comment-posted task-4 thanks-volunteer-4)
    (task-completed))))
