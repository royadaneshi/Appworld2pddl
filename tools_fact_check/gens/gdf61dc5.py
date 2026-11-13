from ed import *
CODE=LOGIN+"""pt=tok('phone'); vt=tok('venmo')
cs=[(c['first_name'],c['last_name'],c['email']) for c in pages(apis.phone.search_contacts,access_token=pt,query=REL,relationship=REL)]
tx=pages(apis.venmo.show_transactions,access_token=vt,min_created_at=DATE)
print('JSON'+json.dumps({'cs':cs,'tx':[(x['transaction_id'],x['sender']['email'],x['receiver']['email'],x['amount'],x['created_at']) for x in tx]}))"""
for t,rel,date in [('df61dc5_1','roommate','2023-01-01'),('df61dc5_2','friend','2023-05-01'),('df61dc5_3','coworker','2023-01-01')]:
    d=envjson(t,f"REL={rel!r}; DATE={date!r}\n"+CODE)
    P={e:dict(p=f"{rel}-{slug(f+' '+l)}",e=f"email-{slug(f+' '+l)}",who=f+' '+l,em=e) for f,l,e in d['cs']}
    T=[]
    for i,se,re_,a,ts in d['tx']:
        c=P.get(se) or P.get(re_)
        if c: T.append(dict(o=f'tx-{i}',id=i,c=c,amt=a,ts=ts,dir='received from' if se in P else 'sent to'))
    want=set(private(t)['to_like_transaction_ids']); assert {x['id'] for x in T}==want,(len(T),len(want))
    to=[x['o'] for x in T]; PL=list(P.values()); me=re.search(r'\(:objects\s+(\S+)',(awcheck.task_dir(t)/'problem.pddl').read_text()).group(1)
    set_objects(t,'person',[me]+[p['p'] for p in PL]); set_objects(t,'email',[p['e'] for p in PL])
    keep=keep_init(t,r'username-for|password-for|target-relationship|relationship-query|year-start|friend-filter|month-start|query-for')
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if x.get('value') is None and re.match(r'(tx|txn)-|.*(roommate|friend|coworker)-[12ab]',x['object'])]
    if t.endswith('_1'):
        sub(t,'domain.pddl','tx-roommate-1-a tx-roommate-1-b tx-roommate-1-old tx-roommate-2-a - transaction',' '.join(to)+' - transaction'); ctask(t,[f'(liked {o})' for o in to])
        init=keep+[f"(has-relationship {p['p']} rel-roommate)" for p in PL]+[f"(email-of {p['p']} {p['e']})" for p in PL]+[f"(transaction-with {x['o']} {x['c']['e']})" for x in T]+[f'(created-on-or-after {o} date-2023-01-01)' for o in to]
    elif t.endswith('_2'):
        sub(t,'domain.pddl','tx-1 tx-2 tx-3 tx-4 - transaction',' '.join(to)+' - transaction'); ctask(t,[f'(liked {o})' for o in to])
        init=keep+[f"(is-friend {p['p']})" for p in PL]+[f"(email-of {p['p']} {p['e']})" for p in PL]+[f"(transaction-with {x['o']} {x['c']['e']})" for x in T]+[f'(in-current-month {o})' for o in to]
    else:
        set_objects(t,'transaction',to)
        init=keep+[f"(has-relationship {p['p']} coworker)" for p in PL]+[f"(contact-email {p['p']} {p['e']})" for p in PL]+[f"(transaction-with {x['o']} {x['c']['p']})" for x in T]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',[f'(liked {o})' for o in to]+['(task-completed)'],wrap_and=True)
    add=[(p['e'],None,'phone.search_contacts',f"email of the {rel} contact {p['who']} ({p['em']})") for p in PL]+[(x['o'],None,'venmo.show_transactions',f"transaction_id of the ${x['amt']} payment {x['dir']} {x['c']['who']} at {x['ts']} (on or after {date})") for x in T]
    binds(t,drop=drop,add=add); print(t,len(PL),'contacts',len(T),'tx; dropped',len(drop))
