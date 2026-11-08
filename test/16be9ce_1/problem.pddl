(define (problem task-16be9ce-1)
  (:domain appworld-16be9ce-1)
  (:objects
    brenda sister - person
    username-9312015677 brenda-webe-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    rel-sister - relationship
    sister-birthday - birthday
    query-bean-bag-chair - query
    bean-bag-chair-order - order
    bean-bag-chair - product
    bean-bag-chair-price - price)
  (:init
    (username-for phone username-9312015677)
    (username-for amazon brenda-webe-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (contact-relationship sister rel-sister)
    (birthday-of sister sister-birthday)
    (ordered-on bean-bag-chair-order sister-birthday)
    (order-matches-query bean-bag-chair-order query-bean-bag-chair)
    (order-contains bean-bag-chair-order bean-bag-chair)
    (current-price bean-bag-chair bean-bag-chair-price))
  (:goal (and (found-price bean-bag-chair bean-bag-chair-price) (task-completed)))
)
