(define (problem task-6b6ca61-2)
  (:domain appworld-6b6ca61-2)
  (:objects
    kathryn - person
    debtor-1 debtor-2 debtor-3 debtor-4 debtor-5 debtor-6 debtor-7 - debtor
    user-kathrynmaldonado-at-gmail-com - username
    pw-file-system pw-venmo pw-splitwise - password
    token-file-system token-venmo token-splitwise - token
    kathrynmaldonado-at-gmail-com email-debtor-1 email-debtor-2 email-debtor-3 email-debtor-4 email-debtor-5 email-debtor-6 email-debtor-7 - email
    query-debtor-1 query-debtor-2 query-debtor-3 query-debtor-4 query-debtor-5 query-debtor-6 query-debtor-7 - query
    amount-debtor-1 amount-debtor-2 amount-debtor-3 amount-debtor-4 amount-debtor-5 amount-debtor-6 amount-debtor-7 - amount
    description-debtor-1 description-debtor-2 description-debtor-3 description-debtor-4 description-debtor-5 description-debtor-6 description-debtor-7 - description
    private-false - privacy
    debt-list-csv receipt-debtor-pdf-1 receipt-debtor-pdf-2 receipt-debtor-pdf-3 receipt-debtor-pdf-4 - file
    flag-recursive-true - flag
  )
  (:init
    (credential-of-app file-system user-kathrynmaldonado-at-gmail-com)
    (credential-of-app file-system pw-file-system)
    (credential-of-app file-system token-file-system)
    (credential-of-app file-system kathrynmaldonado-at-gmail-com)
    (credential-of-app venmo user-kathrynmaldonado-at-gmail-com)
    (credential-of-app venmo pw-venmo)
    (credential-of-app venmo token-venmo)
    (credential-of-app venmo kathrynmaldonado-at-gmail-com)
    (credential-of-app splitwise user-kathrynmaldonado-at-gmail-com)
    (credential-of-app splitwise pw-splitwise)
    (credential-of-app splitwise token-splitwise)
    (credential-of-app splitwise kathrynmaldonado-at-gmail-com)
    (password-for file-system pw-file-system)
    (password-for venmo pw-venmo)
    (password-for splitwise pw-splitwise)
    (account-username user-kathrynmaldonado-at-gmail-com)
    (recursive-flag flag-recursive-true)
    (debt-list-file debt-list-csv)
    (supervisor-email kathrynmaldonado-at-gmail-com)
    (public-privacy private-false)
    (debt-entry debtor-1 email-debtor-1 amount-debtor-1 description-debtor-1)
    (debt-entry debtor-2 email-debtor-2 amount-debtor-2 description-debtor-2)
    (debt-entry debtor-3 email-debtor-3 amount-debtor-3 description-debtor-3)
    (debt-entry debtor-4 email-debtor-4 amount-debtor-4 description-debtor-4)
    (debt-entry debtor-5 email-debtor-5 amount-debtor-5 description-debtor-5)
    (debt-entry debtor-6 email-debtor-6 amount-debtor-6 description-debtor-6)
    (debt-entry debtor-7 email-debtor-7 amount-debtor-7 description-debtor-7)
    (search-query debtor-1 query-debtor-1)
    (search-query debtor-2 query-debtor-2)
    (search-query debtor-3 query-debtor-3)
    (search-query debtor-4 query-debtor-4)
    (search-query debtor-5 query-debtor-5)
    (search-query debtor-6 query-debtor-6)
    (search-query debtor-7 query-debtor-7)
    (has-venmo-account debtor-1)
    (has-venmo-account debtor-2)
    (has-venmo-account debtor-3)
    (receipt-of debtor-4 receipt-debtor-pdf-1)
    (receipt-of debtor-5 receipt-debtor-pdf-2)
    (receipt-of debtor-6 receipt-debtor-pdf-3)
    (receipt-of debtor-7 receipt-debtor-pdf-4))
  (:goal (and
    (debt-settled debtor-1)
    (debt-settled debtor-2)
    (debt-settled debtor-3)
    (debt-settled debtor-4)
    (debt-settled debtor-5)
    (debt-settled debtor-6)
    (debt-settled debtor-7)
    (task-completed)))
)
