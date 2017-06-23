function anonymous

params = ctype_hatchback;

v = pacejka(params.B1,params.C1,params.D1, 0);
assert(v==0)

vp = pacejka(params.B1,params.C1,params.D1, 1);
vn = pacejka(params.B1,params.C1,params.D1,-1);

assert(vp ==-vn)
vp
vn

