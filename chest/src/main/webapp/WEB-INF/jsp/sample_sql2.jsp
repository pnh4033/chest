<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMap PUBLIC "-//iBATIS.com//DTD SQL Map 2.0//EN" "http://www.ibatis.com/dtd/sql-map-2.dtd">

<sqlMap namespace="calendarDAO">

	<select id="calendarDAO.selectSampleList" parameterClass="java.util.HashMap" resultClass="java.util.HashMap">
	select
      (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.11$') as memo11
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.12$') as memo12
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.13$') as memo13
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.14$') as memo14
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.15$') as memo15
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.16$') as memo16
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.17$') as memo17
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.21$') as memo21
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.22$') as memo22
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.23$') as memo23
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.24$') as memo24
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.25$') as memo25
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.26$') as memo26
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.27$') as memo27
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.31$') as memo31
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.32$') as memo32
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.33$') as memo33
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.34$') as memo34
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.35$') as memo35
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.36$') as memo36
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.37$') as memo37
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.41$') as memo41
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.42$') as memo42
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.43$') as memo43
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.44$') as memo44
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.45$') as memo45
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.46$') as memo46
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.47$') as memo47
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.51$') as memo51
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.52$') as memo52
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.53$') as memo53
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.54$') as memo54
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.55$') as memo55
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.56$') as memo56
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.57$') as memo57
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.61$') as memo61
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.62$') as memo62
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.63$') as memo63
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.64$') as memo64
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.65$') as memo65
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.66$') as memo66
    , (select memo from tblSchedule where year = '$year$' and month = '$month$' and day = '$weeks.67$') as memo67
    
from
    dual
	</select>
	
</sqlMap>
