import math

N=298777079680636209728926753957151534560921684339894725163656346441015377896041311169310959917171700706622085676826928556518363105076218043402519861108884785655277921109447616047979259115290265284384151036883100749922693173993355808366922676333229835998998497712492287847117477480037575980851247778265980034106283555720558204023500207676048578837876927418180945214920194972851554780233917446851793705191199191708506603506807978474027

N=439883

N=679219428076639037491621076416118682833666416615087932844998207343805916336938029360786754471465595866678379652832522640152865887238693114765789678411952236515796066475511933964211526963511354802036339292227935041642193887905092509523947677753470436454690219245781918935529396407766556063433339725031383422651667729192894938025566361227982392676863910217446332808770047882849654976968688144010552135888859518800468768983588769

N=1234567891

N=550167741302968195769819414828859082026511587458002285631287495831856132679007143691206492321988954001297916189554068549927049647558583001220942719635296457354402445313160938157115514162931809800354138071640431997629358309550505318888086712562549900671837754158618336312724819122779660939224394363445649845312288078285113068784296092816480347516881848191082051079173942231460201630149708910589634098858042889761555259

N=1732792378957

N=172425204143889239431560306540746061154146941784029535866494953278689749412283726574514880273417823335417065612711736411592890420240423005388147572376052752288477250659614159017687293252488859713666349178103554992944221645084899891001640521207705737728737924253548450417105661132396473570561736722527526024613804684086131824705586309678932856245018746263032099418201893677554220249931482944038760382720303900970399911511

n = int(input('::'))
i = 1
t = 2**int(math.log(N,2))
minn = N - t
minn = min(minn,2*t-N)
t = 3**int(math.log(N,3))
minn = min(minn,N-t)
minn = min(minn,3*t-N)
tt = 5
while tt <= n:
    t = tt**int(math.log(N,tt))
    minn = min(minn,t)
    minn = min(minn,tt*t-N)
    tt += 2
    t = tt**int(math.log(N,tt))
    minn = min(minn,t)
    minn = min(minn,tt*t-N)
    tt += 5

print(minn)
