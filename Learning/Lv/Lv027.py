import calendar
from datetime import datetime
from dateutil.rrule import rrule, DAILY 

tcal = calendar.LocaleTextCalendar(locale='pt_BR.utf8')

data = tcal.formatmonth(2021, 2).split('\n')

print(data)

for x in rrule(DAILY, count = 3, dtstart = datetime.now()):
    print(x)





