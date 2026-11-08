(define (problem task-8ce6779-1)
  (:domain appworld-8ce6779-1)
  (:objects
    jordan colleague-1 colleague-2 - person
    jo-harr-at-gmail-com - username
    todoist-password - password
    todoist-token - token
    jo-harr-at-gmail-com-email colleague-1-email colleague-2-email - email
    flag-false - flag
    work-project - project
    task-1 task-2 task-3 - task-item
    thank-you-colleague-1 thank-you-colleague-2 - comment-text)
  (:init
    (username-for todoist jo-harr-at-gmail-com)
    (password-for todoist todoist-password)
    (supervisor-email jo-harr-at-gmail-com-email)
    (is-false flag-false)
    (in-project task-1 work-project)
    (in-project task-2 work-project)
    (in-project task-3 work-project)
    (volunteer-for task-1 colleague-1)
    (volunteer-for task-2 colleague-2)
    (person-email colleague-1 colleague-1-email)
    (person-email colleague-2 colleague-2-email)
    (thank-you-text colleague-1 thank-you-colleague-1)
    (thank-you-text colleague-2 thank-you-colleague-2))
  (:goal (and
    (comments-checked task-1)
    (comments-checked task-2)
    (comments-checked task-3)
    (reassigned task-1 colleague-1)
    (commented task-1 thank-you-colleague-1)
    (reassigned task-2 colleague-2)
    (commented task-2 thank-you-colleague-2)
    (task-completed)))
)
