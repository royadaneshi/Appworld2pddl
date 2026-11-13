(define (problem task-8ce6779-1)
  (:domain appworld-8ce6779-1)
  (:objects
    jordan colleague-1 colleague-2 colleague-3 colleague-4 - person
    jo-harr-at-gmail-com - username
    todoist-password - password
    todoist-token - token
    jo-harr-at-gmail-com-email colleague-email-1 colleague-email-2 colleague-email-3 colleague-email-4 - email
    flag-false - flag
    work-project - project
    task-1 task-5 task-6 task-2 task-3 task-4 - task-item
    thank-you-colleague-1 thank-you-colleague-2 thank-you-colleague-3 thank-you-colleague-4 - comment-text
  )
  (:init
    (username-for todoist jo-harr-at-gmail-com)
    (password-for todoist todoist-password)
    (supervisor-email jo-harr-at-gmail-com-email)
    (is-false flag-false)
    (in-project task-1 work-project)
    (in-project task-5 work-project)
    (in-project task-6 work-project)
    (in-project task-2 work-project)
    (in-project task-3 work-project)
    (in-project task-4 work-project)
    (volunteer-for task-1 colleague-1)
    (person-email colleague-1 colleague-email-1)
    (thank-you-text colleague-1 thank-you-colleague-1)
    (volunteer-for task-2 colleague-2)
    (person-email colleague-2 colleague-email-2)
    (thank-you-text colleague-2 thank-you-colleague-2)
    (volunteer-for task-3 colleague-3)
    (person-email colleague-3 colleague-email-3)
    (thank-you-text colleague-3 thank-you-colleague-3)
    (volunteer-for task-4 colleague-4)
    (person-email colleague-4 colleague-email-4)
    (thank-you-text colleague-4 thank-you-colleague-4))
  (:goal (and
    (comments-checked task-1)
    (comments-checked task-5)
    (comments-checked task-6)
    (comments-checked task-2)
    (comments-checked task-3)
    (comments-checked task-4)
    (reassigned task-1 colleague-1)
    (commented task-1 thank-you-colleague-1)
    (reassigned task-2 colleague-2)
    (commented task-2 thank-you-colleague-2)
    (reassigned task-3 colleague-3)
    (commented task-3 thank-you-colleague-3)
    (reassigned task-4 colleague-4)
    (commented task-4 thank-you-colleague-4)
    (task-completed)))
)
