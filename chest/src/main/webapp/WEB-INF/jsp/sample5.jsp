/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.calendar;

import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CalendarController {

	@Resource(name="calendarDAO")
	private CalendarDAO calendarDAO;

	@RequestMapping(value="/calendar.do", method=RequestMethod.GET)
	public String calendarGET(Model model, HttpServletRequest request) throws Exception {
		HashMap<String, Object> params = getParams(request);
		Calendar cal=Calendar.getInstance();
		int nowYear=cal.get(cal.YEAR);
		int nowMonth=cal.get(cal.MONTH)+1;
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		
		if(year != null) {
			nowYear=Integer.parseInt(year);
		}
		if(month != null) {
			nowMonth=Integer.parseInt(month);
		}
		
		params.put("year", nowYear);
		params.put("month", nowMonth);
		System.out.println("year : "+nowYear+" , month : "+nowMonth);
		params.put("weeks", myCalendar());
		model.addAttribute("params", params);
		model.addAttribute("result", calendarDAO.selectSampleList(params));
		return "/calendar/calendar";
	}
	
	public HashMap<String, Object> getParams(HttpServletRequest request) throws Exception {
		HashMap<String, Object> params = new HashMap<String, Object>();
		Enumeration<String> enumber=request.getParameterNames();
		
		while(enumber.hasMoreElements()) {
			String key=(String)enumber.nextElement();
			String value=request.getParameter(key);
			System.out.println("getParams() key : "+key+" value : "+value);
			params.put(key, value);
		}
		
		return params;
	}
	
	public HashMap<String, Object> myCalendar() throws Exception {
		HashMap<String, Object> weeks=new HashMap<>();
		Calendar cal=Calendar.getInstance();
		int nowYear=cal.get(cal.YEAR);
		int nowMonth=cal.get(cal.MONTH) + 1 ;
		int date=cal.get(cal.DATE) ;
		String str=nowYear+" "+nowMonth+" "+date+"";
		System.out.println("today : "+str);
		
		Calendar cal2=Calendar.getInstance();
		cal2.set(2017, 8, 1);
		int yoil=cal2.get(Calendar.DAY_OF_WEEK);
		int lastDay=cal2.getActualMaximum(Calendar.DAY_OF_MONTH);
		System.out.println("yoil : "+yoil);
		System.out.println("lastday : "+lastDay);
		int i=1;
			
		for(int y=1; y<=6; y++) {
			for(int x=1; x<=7; x++) {
				String strY=y+"";
				String strX=x+"";
				String keyNum=strY+strX;
				int day=i-yoil+1;
				i++;
				if(day>=1 && day<=lastDay) {
					weeks.put(keyNum, day);
					System.out.println(":: " + keyNum + "=" + day);
				}
			}
		}
		

		System.out.println("weeks.toString() : "+weeks.toString());
		return weeks;
		
	}

}





--------------------------------------------------------------------------------------

dao


/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.calendar;

import java.util.HashMap;
import java.util.List;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import org.springframework.stereotype.Repository;

@Repository("calendarDAO")
public class CalendarDAO extends EgovAbstractDAO {

	public HashMap<String, Object> selectSampleList(HashMap<String, Object> map) throws Exception {
		return (HashMap<String, Object>) select("calendarDAO.selectSampleList", map);
	}

}










