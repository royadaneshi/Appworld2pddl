(define (problem task-afc0fce-1)
  (:domain appworld-afc0fce-1)
  (:objects
    phone-4288705164 jepowell-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-coworker - query
    relationship-coworker - relationship
    date-2023-05-31 - date
    dir-received - direction
    comment-thank-you - comment-text
    jennifer coworker-alexander-riddle coworker-jared-calhoun coworker-brenda-smith coworker-joyce-weaver coworker-sherry-smith coworker-jack-maldonado - person
    email-alexander-riddle email-jared-calhoun email-brenda-smith email-joyce-weaver email-sherry-smith email-jack-maldonado - email
    tx-8246 tx-8247 tx-8248 tx-8251 tx-8252 tx-8263 tx-8264 tx-8266 tx-8267 - transaction
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-4288705164)
    (username-for venmo jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (search-query relationship-coworker query-coworker)
    (threshold-date date-2023-05-31)
    (direction-received dir-received)
    (comment-to-post comment-thank-you)
    (has-relationship coworker-alexander-riddle relationship-coworker)
    (has-relationship coworker-jared-calhoun relationship-coworker)
    (has-relationship coworker-brenda-smith relationship-coworker)
    (has-relationship coworker-joyce-weaver relationship-coworker)
    (has-relationship coworker-sherry-smith relationship-coworker)
    (has-relationship coworker-jack-maldonado relationship-coworker)
    (email-of coworker-alexander-riddle email-alexander-riddle)
    (email-of coworker-jared-calhoun email-jared-calhoun)
    (email-of coworker-brenda-smith email-brenda-smith)
    (email-of coworker-joyce-weaver email-joyce-weaver)
    (email-of coworker-sherry-smith email-sherry-smith)
    (email-of coworker-jack-maldonado email-jack-maldonado)
    (recent-payment-from tx-8246 email-alexander-riddle)
    (recent-payment-from tx-8247 email-sherry-smith)
    (recent-payment-from tx-8248 email-jared-calhoun)
    (recent-payment-from tx-8251 email-jack-maldonado)
    (recent-payment-from tx-8252 email-brenda-smith)
    (recent-payment-from tx-8263 email-sherry-smith)
    (recent-payment-from tx-8264 email-jack-maldonado)
    (recent-payment-from tx-8266 email-alexander-riddle)
    (recent-payment-from tx-8267 email-sherry-smith))
  (:goal (and
    (liked tx-8246)
    (liked tx-8247)
    (liked tx-8248)
    (liked tx-8251)
    (liked tx-8252)
    (liked tx-8263)
    (liked tx-8264)
    (liked tx-8266)
    (liked tx-8267)
    (commented tx-8246 comment-thank-you)
    (commented tx-8247 comment-thank-you)
    (commented tx-8248 comment-thank-you)
    (commented tx-8251 comment-thank-you)
    (commented tx-8252 comment-thank-you)
    (commented tx-8263 comment-thank-you)
    (commented tx-8264 comment-thank-you)
    (commented tx-8266 comment-thank-you)
    (commented tx-8267 comment-thank-you)
    (task-completed)))
)
