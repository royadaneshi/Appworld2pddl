(define (problem task-c77c005-3)
  (:domain appworld-c77c005-3)
  (:objects
    stacy-maldonado alice-chen brian-ortiz carla-ruiz derek-wong - person
    st-maldonado-at-gmail-com - username
    venmo-password - password
    venmo-token - token
    alice-chen-at-gmail-com brian-ortiz-at-gmail-com carla-ruiz-at-gmail-com derek-wong-at-gmail-com - email
    direction-received - direction
    datetime-2023-05-01t00-00-00 - datetime)
  (:init
    (password-for venmo venmo-password)
    (email-of alice-chen alice-chen-at-gmail-com)
    (email-of brian-ortiz brian-ortiz-at-gmail-com)
    (email-of carla-ruiz carla-ruiz-at-gmail-com)
    (email-of derek-wong derek-wong-at-gmail-com)
    (received-from-this-month alice-chen)
    (received-from-this-month brian-ortiz)
    (friend brian-ortiz)
    (friend carla-ruiz)
    (friend derek-wong))
  (:goal (and
    (friend alice-chen)
    (friend brian-ortiz)
    (not (friend carla-ruiz))
    (not (friend derek-wong))
    (task-completed)))
)
