(define (problem task-8ce6779-3)
  (:domain appworld-8ce6779-3)
  (:objects
    jessica-miller volunteer-a volunteer-b - person
    jes-mill-username - username
    todoist-password - password
    todoist-token - token
    jes-mill-at-gmail-com volunteer-a-email volunteer-b-email - email
    work-project - project
    task-1 task-2 task-3 - task-item
    thanks-volunteer-a thanks-volunteer-b - comment-text
    flag-false - flag)
  (:init
    (password-for todoist todoist-password)
    (is-supervisor jessica-miller)
    (person-email jessica-miller jes-mill-at-gmail-com)
    (person-email volunteer-a volunteer-a-email)
    (person-email volunteer-b volunteer-b-email)
    (task-in-project task-1 work-project)
    (task-in-project task-2 work-project)
    (task-in-project task-3 work-project)
    (volunteer-for task-1 volunteer-a)
    (volunteer-for task-2 volunteer-b)
    (no-volunteer task-3)
    (thank-you-text volunteer-a thanks-volunteer-a)
    (thank-you-text volunteer-b thanks-volunteer-b))
  (:goal (and
    (comments-read task-1)
    (comments-read task-2)
    (comments-read task-3)
    (reassigned task-1 volunteer-a)
    (commented task-1 thanks-volunteer-a)
    (reassigned task-2 volunteer-b)
    (commented task-2 thanks-volunteer-b)
    (task-completed))))
