@RequestMapping(value = "/egovSampleList2.do")
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, 
			ModelMap model, HttpSession session) throws Exception {
 
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
 
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
 
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
 
		List<?> sampleList = sampleService.selectSampleList(searchVO);
		model.addAttribute("resultList", sampleList);
		
		
		model.addAttribute("loginValue", session.getAttribute("login"));
		
 
		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
 
		return "sample/egovSampleList2";
	}
	
	
	//ajax
	@RequestMapping(value="/loginCheck.do")
	public String loginAjax(Model model, HttpSession session) throws Exception {
		
		model.addAttribute("loginValue", session.getAttribute("login"));
		System.out.println("login: " + session.getAttribute("login"));
		return "sample/loginCheck";
		
	}
	
	
	
	@RequestMapping(value="/login.do")
	public String login(HttpSession session) throws Exception {
		
		session.setAttribute("login", "true");
		
		return "forward:/egovSampleList2.do";
		
	}
	
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) throws Exception {
		
		session.setAttribute("login", null);
		
		return "forward:/egovSampleList2.do";
		
	}