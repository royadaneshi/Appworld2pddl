from ed import *
CODE=LOGIN+"""pt=tok('phone'); vt=tok('venmo')
cs=[(c['first_name'],c['last_name'],c['email']) for c in pages(apis.phone.search_contacts,access_token=pt,query=REL,relationship=REL)]
tx=pages(apis.venmo.show_transactions,access_token=vt,direction='received',min_created_at=DATE)
print('JSON'+json.dumps({'cs':cs,'tx':[(x['transaction_id'],x['sender']['email'],x['amount'],x['created_at']) for x in tx]}))"""
for t,rel,date in [('afc0fce_1','coworker','2023-05-31'),('afc0fce_2','friend','2023-05-26'),('afc0fce_3','roommate','2023-05-24')]:
    d=envjson(t,f"REL={rel!r}; DATE={date!r}\n"+CODE)
    P={e:dict(p=f"{rel}-{slug(f+' '+l)}",e=f"email-{slug(f+' '+l)}",who=f+' '+l,em=e) for f,l,e in d['cs']}
    T=[dict(o=f'tx-{i}',id=i,s=P[e],amt=a,ts=ts) for i,e,a,ts in d['tx'] if e in P]
    assert {x['id'] for x in T}==set(private(t)['after_threshold_contact_transaction_ids']),(len(T),)
    to=[x['o'] for x in T]; PL=list(P.values()); me=re.search(r'\(:objects\s+(\S+)',(awcheck.task_dir(t)/'problem.pddl').read_text()).group(1)
    set_objects(t,'person',[me]+[p['p'] for p in PL]); set_objects(t,'email',[p['e'] for p in PL])
    keep=keep_init(t,r'username-for|password-for|search-query|threshold-date|direction-received|comment-to-post|window-start|target-query|target-relationship|min-created-at|received-direction|target-comment')
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(tx|txn)-|.*(coworker|friend|roommate)-?[12ab]',x['object']) and x.get('value') is None]
    if t.endswith('_1'):
        set_objects(t,'transaction',to); c='comment-thank-you'
        init=keep+[f"(has-relationship {p['p']} relationship-coworker)" for p in PL]+[f"(email-of {p['p']} {p['e']})" for p in PL]+[f"(recent-payment-from {x['o']} {x['s']['e']})" for x in T]
    elif t.endswith('_2'):
        sub(t,'domain.pddl','txn-1 txn-2 txn-3 - transaction',' '.join(to)+' - transaction'); c='comment-thanks'
        ctask(t,[f'(liked {o})' for o in to]+[f'(commented {o} {c})' for o in to])
        init=keep+[f"(friend-email {p['p']} {p['e']})" for p in PL]+[f"(received-from {x['o']} {x['s']['p']})" for x in T]
    else:
        set_objects(t,'transaction',to); c='comment-thank-you-so-much'
        init=keep+[f"(is-roommate {p['p']})" for p in PL]+[f"(contact-email {p['p']} {p['e']})" for p in PL]+[f"(received-from {x['o']} {x['s']['p']})" for x in T]+[f'(in-window {o})' for o in to]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',[f'(liked {o})' for o in to]+[f'(commented {o} {c})' for o in to]+['(task-completed)'],wrap_and=True)
    add=[(p['e'],None,'phone.search_contacts',f"email of the {rel} contact {p['who']} ({p['em']})") for p in PL]+[(x['o'],None,'venmo.show_transactions',f"transaction_id of the payment of ${x['amt']} received from {x['s']['who']} at {x['ts']} (on or after {date})") for x in T]
    binds(t,drop=drop,add=add); print(t,len(PL),'contacts',len(T),'tx','dropped',drop)
