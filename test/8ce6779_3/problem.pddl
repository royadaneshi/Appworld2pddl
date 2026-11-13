(define (problem task-8ce6779-3)
  (:domain appworld-8ce6779-3)
  (:objects
    jessica-miller volunteer-1 volunteer-2 volunteer-3 volunteer-4 - person
    jes-mill-username - username
    todoist-password - password
    todoist-token - token
    jes-mill-at-gmail-com volunteer-email-1 volunteer-email-2 volunteer-email-3 volunteer-email-4 - email
    work-project - project
    task-1 task-5 task-6 task-2 task-7 task-3 task-8 task-4 - task-item
    thanks-volunteer-1 thanks-volunteer-2 thanks-volunteer-3 thanks-volunteer-4 - comment-text
    flag-false - flag
  )
  (:init
    (password-for todoist todoist-password)
    (is-supervisor jessica-miller)
    (person-email jessica-miller jes-mill-at-gmail-com)
    (task-in-project task-1 work-project)
    (task-in-project task-5 work-project)
    (task-in-project task-6 work-project)
    (task-in-project task-2 work-project)
    (task-in-project task-7 work-project)
    (task-in-project task-3 work-project)
    (task-in-project task-8 work-project)
    (task-in-project task-4 work-project)
    (volunteer-for task-1 volunteer-1)
    (person-email volunteer-1 volunteer-email-1)
    (thank-you-text volunteer-1 thanks-volunteer-1)
    (volunteer-for task-2 volunteer-2)
    (person-email volunteer-2 volunteer-email-2)
    (thank-you-text volunteer-2 thanks-volunteer-2)
    (volunteer-for task-3 volunteer-3)
    (person-email volunteer-3 volunteer-email-3)
    (thank-you-text volunteer-3 thanks-volunteer-3)
    (volunteer-for task-4 volunteer-4)
    (person-email volunteer-4 volunteer-email-4)
    (thank-you-text volunteer-4 thanks-volunteer-4)
    (no-volunteer task-5)
    (no-volunteer task-6)
    (no-volunteer task-7)
    (no-volunteer task-8))
  (:goal (and
    (comments-read task-1)
    (comments-read task-5)
    (comments-read task-6)
    (comments-read task-2)
    (comments-read task-7)
    (comments-read task-3)
    (comments-read task-8)
    (comments-read task-4)
    (reassigned task-1 volunteer-1)
    (commented task-1 thanks-volunteer-1)
    (reassigned task-2 volunteer-2)
    (commented task-2 thanks-volunteer-2)
    (reassigned task-3 volunteer-3)
    (commented task-3 thanks-volunteer-3)
    (reassigned task-4 volunteer-4)
    (commented task-4 thanks-volunteer-4)
    (task-completed))))
