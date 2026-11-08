(define (problem task-dbc0276-3)
  (:domain appworld-dbc0276-3)
  (:objects
    brenda brenda-partner - person
    brenda-webe-at-gmail-com username-9312015677 - username
    amazon-password phone-password - password
    amazon-token phone-token - token
    relation-partner - relationship
    partner-phone-number - phone-number
    message-wish-list-itemized - message
    brenda-wish-list - wish-list)
  (:init
    (username-for amazon brenda-webe-at-gmail-com)
    (username-for phone username-9312015677)
    (password-for amazon amazon-password)
    (password-for phone phone-password)
    (has-relationship brenda-partner relation-partner)
    (is-partner brenda-partner)
    (phone-number-of brenda-partner partner-phone-number)
    (message-itemizes message-wish-list-itemized brenda-wish-list))
  (:goal (and (text-sent brenda-partner message-wish-list-itemized) (task-completed)))
)
