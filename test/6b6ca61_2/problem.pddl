(define (problem task-6b6ca61-2)
  (:domain appworld-6b6ca61-2)
  (:objects
    kathryn - person
    debtor-1 debtor-2 debtor-3 - debtor
    user-kathrynmaldonado-at-gmail-com - username
    pw-file-system pw-venmo pw-splitwise - password
    token-file-system token-venmo token-splitwise - token
    kathrynmaldonado-at-gmail-com email-debtor-1 email-debtor-2 email-debtor-3 - email
    query-debtor-1 query-debtor-2 query-debtor-3 - query
    amount-debtor-1 amount-debtor-2 amount-debtor-3 - amount
    description-debtor-1 description-debtor-2 description-debtor-3 - description
    private-false - privacy
    debt-list-csv receipt-debtor-1-pdf receipt-debtor-2-pdf receipt-debtor-3-pdf - file
    flag-recursive-true - flag)
  (:init
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
    (search-query debtor-1 query-debtor-1)
    (search-query debtor-2 query-debtor-2)
    (search-query debtor-3 query-debtor-3)
    (has-venmo-account debtor-1)
    (has-venmo-account debtor-2)
    (receipt-of debtor-1 receipt-debtor-1-pdf)
    (receipt-of debtor-2 receipt-debtor-2-pdf)
    (receipt-of debtor-3 receipt-debtor-3-pdf))
  (:goal (and
    (debt-settled debtor-1)
    (debt-settled debtor-2)
    (debt-settled debtor-3)
    (task-completed)))
)
