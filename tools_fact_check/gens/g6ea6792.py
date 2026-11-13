from ed import *
CODE=LOGIN+"""pt=tok('phone'); vt=tok('venmo')
cs={r:[(c['first_name'],c['last_name'],c['email']) for c in pages(apis.phone.search_contacts,access_token=pt,query=r,relationship=r)] for r in RELS}
rq=pages(apis.venmo.show_received_payment_requests,access_token=vt,status='pending')
print('JSON'+json.dumps({'cs':cs,'rq':[(r['payment_request_id'],r['sender']['email'],r['sender']['name'],r['amount'],r['created_at']) for r in rq]}))"""
cfg={'6ea6792_1':(['roommate','coworker'],{'roommate':'roommate','coworker':'coworker'}),'6ea6792_2':(['friend','roommate'],{'friend':'rel-friend','roommate':'rel-roommate'}),'6ea6792_3':(['coworker','friend'],{'coworker':'coworker','friend':'friend'})}
for t,(rels,robj) in cfg.items():
    d=envjson(t,f"RELS={rels!r}\n"+CODE); em={}
    for r in rels:
        for f,l,e in d['cs'][r]: em.setdefault(e,(f"{r}-{slug(f+' '+l)}",robj[r],f+' '+l,r))
    R=[dict(o=f'request-{i}',id=i,p=em[e][0],who=n,amt=a,ts=ts,rel=em[e][3]) for i,e,n,a,ts in d['rq'] if e in em]
    assert {r['id'] for r in R}==set(private(t)['to_accept_payment_request_ids']),(len(R),len(private(t)['to_accept_payment_request_ids']))
    ro=[r['o'] for r in R]; ps=sorted({r['p'] for r in R}); prel={v[0]:v[1] for v in em.values()}; n=len(R)
    p=(awcheck.task_dir(t)/'problem.pddl').read_text(); me=re.search(r'\(:objects\s+(\S+)',p).group(1)
    set_objects(t,'person',[me]+ps)
    keep=keep_init(t,r'username-for|password-for|query-for|target-relationship|pending-status|relationship-query|pending-filter')
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(req|pr)-from',x['object'])]
    if t.endswith('_1'):
        sub(t,'domain.pddl','req-from-roommate req-from-coworker - payment-request',' '.join(ro)+' - payment-request'); ctask(t,[f'(approved {o})' for o in ro]); set_objects(t,'payment-request',[])
        init=keep+[f'(has-relationship {q} {prel[q]})' for q in ps]+[f'(pending {o})' for o in ro]+[f"(requested-by {r['o']} {r['p']})" for r in R]; goal=[f'(approved {o})' for o in ro]
    elif t.endswith('_2'):
        set_objects(t,'payment-request',ro); set_objects(t,'count',[f'count-{i}' for i in range(n,0,-1)])
        init=keep+[f'(contact-relation {q} {prel[q]})' for q in ps]+[f"(request-from {r['o']} {r['p']})" for r in R]+[f'(pending {o})' for o in ro]+[f'(remaining count-{n})']+[f'(next-count count-{i} count-{i-1})' for i in range(n,0,-1)]
        goal=[f'(denied {o})' for o in ro]+['(remaining count-0)']
    else:
        set_objects(t,'payment-request',ro)
        init=keep+[f'(has-relationship {q} {prel[q]})' for q in ps]+[f'(pending-request {o})' for o in ro]+[f"(request-from {r['o']} {r['p']})" for r in R]; goal=[f'(approved {o})' for o in ro]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    binds(t,drop=drop,add=[(r['o'],None,'venmo.show_received_payment_requests',f"payment_request_id of the pending request of ${r['amt']} from {r['who']} ({r['rel']} contact) created at {r['ts']}") for r in R]); print(t,len(ps),'senders',n,'requests')
