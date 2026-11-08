(define (problem task-6b6ca61-3)
  (:domain appworld-6b6ca61-3)
  (:objects
    cesar-maldonado debtor-1 debtor-2 debtor-3 - person
    user-ce-maldonado-at-gmail-com - username
    password-file-system password-venmo password-splitwise - password
    token-file-system token-venmo token-splitwise - token
    ce-maldonado-at-gmail-com email-debtor-1 email-debtor-2 email-debtor-3 - email
    amount-debtor-1 amount-debtor-2 amount-debtor-3 - amount
    description-debtor-1 description-debtor-2 description-debtor-3 - description
    private-true - privacy
    list-of-debts-csv receipt-debtor-1 receipt-debtor-2 receipt-debtor-3 - path
    home-dir - dirpath
    recursive-true - flag
  )
  (:init
    (username-for file-system user-ce-maldonado-at-gmail-com)
    (username-for venmo user-ce-maldonado-at-gmail-com)
    (username-for splitwise user-ce-maldonado-at-gmail-com)
    (password-for file-system password-file-system)
    (password-for venmo password-venmo)
    (password-for splitwise password-splitwise)
    (home-directory home-dir)
    (flag-true recursive-true)
    (csv-file list-of-debts-csv)
    (privacy-private private-true)
    (supervisor-email ce-maldonado-at-gmail-com)
    (person-email cesar-maldonado ce-maldonado-at-gmail-com)
    (person-email debtor-1 email-debtor-1)
    (person-email debtor-2 email-debtor-2)
    (person-email debtor-3 email-debtor-3)
    (owes debtor-1 amount-debtor-1 description-debtor-1)
    (owes debtor-2 amount-debtor-2 description-debtor-2)
    (owes debtor-3 amount-debtor-3 description-debtor-3)
    (receipt-for debtor-1 receipt-debtor-1)
    (receipt-for debtor-2 receipt-debtor-2)
    (receipt-for debtor-3 receipt-debtor-3)
    (has-venmo-account debtor-1)
    (has-venmo-account debtor-2)
  )
  (:goal (and
    (debt-settled debtor-1)
    (debt-settled debtor-2)
    (debt-settled debtor-3)
    (task-completed)
  ))
)
