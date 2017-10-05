<sqlMap namespace="happyrentDAO">
 
	<select id="happyrentDAO.selectSampleList" parameterClass="java.util.HashMap" resultClass="java.util.HashMap">
		select carname, normalcost, b.name as name_cartype, c.name as name_fuel, d.name as name_fuelcost
		from tblmain a 
		join tblcartype b on (a.cartype=b.code)
		join tblfuel c on (a.fuel=c.code) 
		join tblfuelcost d on (a.fuelcost=d.code)
		where
			1=1
			<!-- and #M_size#=b.code and #M_ratio#=d.code and #M_oil#=c.code -->
			<isNotEmpty prepend="and" property="M_size"> $M_size$=b.code</isNotEmpty>
			<isNotEmpty prepend="and" property="M_ratio"> $M_ratio$=d.code</isNotEmpty>
			<isNotEmpty prepend="and" property="M_oil"> $M_oil$=c.code</isNotEmpty>
	</select>
	
</sqlMap>
 
 
---------------------------------------------------------------------------------------------------------
 
 
happyrent.co.kr.jsp
 
 
<body style="opacity:0;">
<div id="mask" onclick="Pclose();"></div>
<div id="docContainer">	
 
   <!-- BODY -->
   <script type="text/javascript" src="js/ui.datepicker.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui-1.7.2.custom.css" />
<script type="text/javascript">
var sdate,stime,sminute,edate,etime,eminute,rental_time,searchFlag = false;
 
$(function() {	
	sdate=$("#sdate").val();
	stime=$("#stime").val();
	sminute=$("#sminute").val();
	edate=$("#edate").val();
	etime=$("#etime").val();
	eminute=$("#eminute").val();
	rental_time=$(".rental_time strong").text();
	$(".reserv1_img").click(function(){
		$("#datepicker_reserv1").focus();		
	});
	$(".reserv2_img").click(function(){
		$("#datepicker_reserv2").focus();		
	});
	$("#datepicker_reserv1").datepicker({
		maxDate: "+180D"
	});
	$("#datepicker_reserv2").datepicker({
		maxDate: "+180D",
		onSelect: function (dateText, inst) {
            var sStartDate = jQuery.trim($('#datepicker_reserv1').val());
            if (sStartDate.length>0) {
                var iStartDate = parseInt(sStartDate.replace(/-/g, ''));
                var iEndDate  = parseInt(jQuery.trim(dateText).replace(/-/g, ''));
                
                if (iStartDate>iEndDate) {
                    alert('대여일보다 반납일이 과거일 수 없습니다.');                   
					reserv_check();
                }
            }
			ChangDateA();
        }
	});	
	$(".car_type a").click(function(){
		$("#car_type").val($(this).attr("data-car"));
		$(this).parent().parent().find("a").removeClass("on");
		$(this).addClass("on");
		carSearch();
	});
	$(".car_mileage a").click(function(){
		$("#car_mileage").val($(this).attr("data-car"));
		$(this).parent().parent().find("a").removeClass("on");
		$(this).addClass("on");
		carSearch();
	});
	$(".car_fuel a").click(function(){
		$("#car_fuel").val($(this).attr("data-car"));
		$(this).parent().parent().find("a").removeClass("on");
		$(this).addClass("on");
		carSearch();
	});
});
function reserv_check(){
	var flag_date = $('#datepicker_reserv1').val();	
 
	var flag_time = new Date(flag_date.substr(0,4), flag_date.substr(5,2)-1, flag_date.substr(8,2),0,0,0,0); 
	var mktime = flag_time.getTime() + (24 * 60 * 60 * 1000 * 1); 
	var str_date= new Date(); 
	str_date.setTime(mktime); 
 
	var year  = str_date.getFullYear(); 
	var month = str_date.getMonth()+1; 
	var day  = str_date.getDate(); 
 
	if(month < 10) month = "0" + month; 
	if(day < 10) day = "0" + day; 
 
	var result_date = year.toString() + '-' + month.toString() + '-' + day.toString(); 
	$("#datepicker_reserv2").val(result_date);
	totalRentalTime();
}
 
function reserv_hour_check(){
	if ( $("#stime").val()+$("#sminute").val() == '800' ) {
		alert('대여시간은 08:30부터 가능합니다.');
		$("#sminute").val("30");
		$("#eminute").val("30");
	}
	if ( $("#stime").val()+$("#sminute").val() == '2230' ) {
		alert('대여시간은 22:00까지 가능합니다.');
		$("#sminute").val("00");
	}
	var flag_date = $('#datepicker_reserv1').val();	
	var flag_hour = $('#stime').val();		
	if ( flag_hour > 21 || $("#stime").val()+$("#sminute").val() == '2100' ) {
		var flag_time = new Date(flag_date.substr(0,4), flag_date.substr(5,2)-1, flag_date.substr(8,2),0,0,0,0); 
		var mktime = flag_time.getTime() + (47 * 60 * 60 * 1000 * 1); 
		var str_date= new Date(); 
		str_date.setTime(mktime); 
 
		var year  = str_date.getFullYear(); 
		var month = str_date.getMonth()+1; 
		var day  = str_date.getDate(); 
 
		if(month < 10) month = "0" + month; 
		if(day < 10) day = "0" + day; 
 
		var result_date = year.toString() + '-' + month.toString() + '-' + day.toString(); 		
		$("#datepicker_reserv2").val(result_date);
		$("#etime").val(9);
	} else {
		$("#etime").val(flag_hour);
	}
	totalRentalTime();
}
function reserv_minute_check(){	
	if ( $("#stime").val()+$("#sminute").val() == '800' ) {
		alert('대여시간은 08:30부터 가능합니다.');
		$("#sminute").val("30");
	}
	if ($("#stime").val() + $("#sminute").val() == '2230') {
	    alert('대여시간은 22:00까지 가능합니다.');
	    $("#sminute").val("00");
	}
	/*if ( $("#stime").val()+$("#sminute").val() == '1930' ) {
		alert('대여시간은 19:00까지 가능합니다.');
		$("#sminute").val("00");
	}*/
	var flag_minute = $('#sminute').val();		
	$("#eminute").val(flag_minute);	
	totalRentalTime();
}
function totalRentalTime(){
	var frm=document.carForm;
	var Stime = new Date(frm.sdate.value.substr(0,4), String(Number(frm.sdate.value.substr(5, 2)) -1 ), frm.sdate.value.substr(8,2),frm.stime.value,frm.sminute.value);	
	var Etime = new Date(frm.edate.value.substr(0, 4), String(Number(frm.edate.value.substr(5, 2)) -1 ), frm.edate.value.substr(8, 2), frm.etime.value,frm.eminute.value );
	var Tmin=(Etime-Stime)/60000;	
	$('.rental_time strong').text(Math.ceil(Tmin/60));
}
function ChangDateA(type)
{	
	if ( !searchFlag ) {
		if ( type == 'hour' ) {
			reserv_hour_check();
			return;
		} else if ( type == 'minute' ) {
			reserv_minute_check();		
			return;
		}
	}
	
	if ( $("#stime").val()+$("#sminute").val() == '800' ) {
		alert('대여시간은 08:30부터 가능합니다.');
		$("#sminute").val("30");
	}
	if ($("#stime").val() + $("#sminute").val() == '2230') {
	    alert('대여시간은 22:00까지 가능합니다.');
	    $("#sminute").val("00");
	}
 
	//var date1 = new Date();
	//var date2 = new Date(2015, 10, 01);
	//var interval = date2 - date1;
	//var day = 1000 * 60 * 60 * 24;
	//var mi = (parseInt(interval / day));
	//if (mi <= 0) {
	//    console.log('바꿈');
	//    if ($("#stime").val() + $("#sminute").val() == '2230') {
	//        alert('대여시간은 22:00까지 가능합니다.');
	//        $("#sminute").val("00");
	//    }
	//}
	//else {
	//    console.log('이전');
	//    if ($("#stime").val() + $("#sminute").val() == '2130') {
	//        alert('대여시간은 21:00까지 가능합니다.');
	//        $("#sminute").val("00");
	//    }
	//}
 
	/*if ( $("#etime").val()+$("#eminute").val() == '800' ) {
		alert('반납시간은 08:30부터 가능합니다.');
		$("#eminute").val("30");
	}*/
 
	/*if ( $("#etime").val()+$("#eminute").val() == '1930' ) {
		alert('반납시간은 19:00까지 가능합니다.');
		$("#eminute").val("00");
	}*/
 
	totalRentalTime();	
	/*
	if ( $('.rental_time strong').text() <  25 ) {
		alert("대여시간이 24시간 이하인 경우 홈페이지 예약은 이용하실 수 없습니다. 고객센터(1644-7935)로 문의주세요.");		
		reserv_check();//ChangDateA();
	}	
	*/
	if ( searchFlag )
		carSearch();
}
function techbug(){	
	//var h = $("#smartSlip").height();		
	//if( h < 35 )
	//	$("#smartSlip").height(480);
	//else
    //	$("#smartSlip").height(30);
    if (IsMobile()) {
        $("#smartSlip").height(30);
    }
}
function SmartView(){
 
        if ($("#smartSlip").height() == 480) {
            $("#smartSlip").height(30);
        }
        else {
            $("#smartSlip").height(480);
        }
}
function IsMobile() {
    var isMobile = {
        Android: function () {
            return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function () {
            return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function () {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function () {
            return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function () {
            return navigator.userAgent.match(/IEMobile/i);
        },
        any: function () {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
    }
    if (isMobile.any()) {
        return true;
    }
    else {
        return false;
    }
}
function carSearch()
{	
	var frm=document.carForm;
 
	var Stime = new Date(frm.sdate.value.substr(0,4),String(Number(frm.sdate.value.substr(5, 2)) -1 ),frm.sdate.value.substr(8,2),frm.stime.value,frm.sminute.value);
	var Etime = new Date(frm.edate.value.substr(0,4),String(Number(frm.edate.value.substr(5, 2)) -1 ),frm.edate.value.substr(8,2),frm.etime.value,frm.eminute.value);
 
	var Tmin=(Etime-Stime)/60000;
	/*
	if ( Math.ceil(Tmin/60) <  24 ) {
		alert("대여시간이 24시간 이하인 경우 홈페이지 예약은 이용하실 수 없습니다. 고객센터(1644-7935)로 문의주세요.");		
		$("#sdate").val(sdate);
		$("#stime").val(stime);
		$("#sminute").val(sminute);
		$("#edate").val(edate);
		$("#etime").val(etime);
		$("#eminute").val(eminute);
		$(".rental_time strong").text(rental_time);
		return;
	}
	*/
	sdate=$("#sdate").val();
	stime=$("#stime").val();
	sminute=$("#sminute").val();
	edate=$("#edate").val();
	etime=$("#etime").val();
	eminute=$("#eminute").val();
	rental_time=$(".rental_time strong").text();
	$("#contents").empty().removeClass("img_rent01");		
	showLoading();
	
 
	
		var checkTime = stime+sminute;
		if(checkTime == '2030' || checkTime == '2100' || checkTime == '2130' || checkTime == '2200')
		{
			alert('20시30분 부터 야간 배차시간입니다.\n야간 배차시간은 차량인수시 배차비용 5,000원이 추가됩니다.\n(야간배차시간 20:30~22:00)');
		}
	
 
	var stringData = $("#carForm").serialize();
	$.ajax(
		{
			type:"post",
			dataType:"html",
			url: "/happyrentWrap.do",
			data: stringData,
			success: function(data) {
				if ( data == "block" ) {
					alert("홈페이지 예약이 가능한 기간이 아닙니다. 자세한 예약상담은 고객센터(1644-7935)로 문의하세요.");
					location.href="/rental";
				}
				if ($(window).width() < 900)
				    //console.log('a');
					techbug();
				$('#contentsWrap').empty().hide();
				$('#contentsWrap').append(data).fadeIn(1000);					
				searchFlag = true;
				return;
			}
		}
	);
}
function mTypeChg(v){
	$("#car_type").val(v);
}
 
function DateChange1() {
    var date1 = new Date();
    var date2 = new Date(2015, 10, 01);
    var interval = date2 - date1;
    var day = 1000 * 60 * 60 * 24;
    var mi = (parseInt(interval / day));
    if (mi <= 0) {
        console.log('바꿈');
        $("#stime").append("<option value=\"22\">22시</option>");
    }
    else {
        console.log('이전');
    }
}
 
</script>
 
<div class="smart_search" id="smartSlip">
	<p class="btn_smartOpen"><a href="#열기" onclick="javascript: SmartView();">검색 열기</a></p>
	<h2><img src="images/contents/txt_smart.png" alt="스마트 서치" /></h2>
	<p class="smart_coment">원하시는 차량을 조건으로 찾아보세요!</p>
	<form name="carForm" id="carForm" method="post">
	<input type="hidden" name="M_size" id="car_type" />
	<input type="hidden" name="M_ratio" id="car_mileage" />
	<input type="hidden" name="M_oil" id="car_fuel" />
	<input type="hidden" name="view_type" id="view_type" value="1" />
	<input type="hidden" name="canUse" id="canUse" value="0" />
	<input type="hidden" name="car_charge" id="car_charge" value="2" />	
	<ul class="smart_list">
		<li><span>대여장소</span> 
			<span class="white">제주공항</span>
		</li>
		<li class="mDpi_el"><span>차종</span> 
			<select class="input_size02" onchange="mTypeChg(this.value);">
				<option value="">전체</option><option value="2" >경차</option><option value="4" >소형</option><option value="3" >중형</option><option value="5" >쿠페</option><option value="6" >고급</option><option value="7" >SUV</option><option value="8" >승합</option><option value="9" >수입</option>			</select>
		</li>
		<li><span>대여일</span> 
			<span>
				<input type="text" title="" name="sdate" class="input_text input_size02" id="datepicker_reserv1" readonly="readonly" value="2016-03-18" onchange="reserv_check();" size="16" />
				<a href="#date" class="reserv1_img"><img src="images/btn/btn_cha.png" alt="달력보기" /></a><br />
				<select class="sel_size01" name="stime" id="stime" onchange="ChangDateA('hour');">
					<option value="8">08시</option>
					<option value="9">09시</option>
					<option value="10">10시</option>
					<option value="11">11시</option>
					<option value="12">12시</option>
					<option value="13">13시</option>
					<option value="14">14시</option>
					<option value="15">15시</option>
					<option value="16">16시</option>
					<option value="17">17시</option>
					<option value="18">18시</option>
					<option value="19">19시</option>
					<option value="20">20시</option>
					<option value="21">21시</option>
                    <option value="22">22시</option>
				</select>
				<select class="sel_size01" name="sminute" id="sminute" onchange="ChangDateA('minute');">
					<option value="00">00분</option>
					<option value="30" selected="selected">30분</option>
				</select>
			</span>
		</li>
		<li><span>반납일</span> 
			<span>
				<input type="text" title="" name="edate" class="input_text input_size02" id="datepicker_reserv2" readonly="readonly" value="2016-03-19" size="16" />
				<a href="#date" class="reserv2_img"><img src="images/btn/btn_cha.png" alt="달력보기" /></a><br />
				<select class="sel_size01" name="etime" id="etime" onchange="ChangDateA();">
					<option value="7" selected>07시</option>
					<option value="8">08시</option>
					<option value="9">09시</option>
					<option value="10">10시</option>
					<option value="11">11시</option>
					<option value="12">12시</option>
					<option value="13">13시</option>
					<option value="14">14시</option>
					<option value="15">15시</option>
					<option value="16">16시</option>
					<option value="17">17시</option>
					<option value="18">18시</option>
					<option value="19">19시</option>
				</select>
				<select class="sel_size01" name="eminute" id="eminute" onchange="ChangDateA();">
					<option value="00" selected="selected">00분</option>
					<option value="30">30분</option>
				</select>
			</span>
		</li>
		<li><span>대여시간</span> 
			<span class="rental_time"><strong>24</strong>시간</span>
		</li>
	</ul>
	</form>
	<p class="btn_smart"><a href="#search" onclick="carSearch();">검색하기</a></p>
	<h3>차종선택</h3>
	<div class="smart_list02 car_type">
		<span class="bin01"><img src="images/contents/bg_roundLt.png" alt="" /></span>
		<span class="bin02"><img src="images/contents/bg_roundLr.png" alt="" /></span>
		<ul>
			<li class="item01"><a href="#" class="on">전체</a></li>
			<li><a href='#' data-car='2'>경차</a></li><li><a href='#' data-car='4'>소형</a></li><li class='item01'><a href='#' data-car='3'>중형</a></li><li><a href='#' data-car='5'>쿠페</a></li><li><a href='#' data-car='6'>고급</a></li><li class='item01'><a href='#' data-car='7'>SUV</a></li><li><a href='#' data-car='8'>승합</a></li><li><a href='#' data-car='9'>수입</a></li>			
		</ul>
	</div>
	<h3>연비</h3>
	<div class="smart_list02 car_mileage">
		<span class="bin01"><img src="images/contents/bg_roundLt.png" alt="" /></span>
		<span class="bin02"><img src="images/contents/bg_roundLr.png" alt="" /></span>
		<ul class="type01">
			<li class="item01"><a href="#" class="on">전체</a></li>
			<li><a href="#" data-car="A">A</a></li>
			<li><a href="#" data-car="B">B</a></li>
			<li><a href="#" data-car="C">C</a></li>
			<li><a href="#" data-car="D">D</a></li>
			<li><a href="#" data-car="E">E</a></li>
		</ul>
	</div>
	<h3>연료</h3>
	<div class="smart_list02 car_fuel">
		<span class="bin01"><img src="images/contents/bg_roundLt.png" alt="" /></span>
		<span class="bin02"><img src="images/contents/bg_roundLr.png" alt="" /></span>
		<ul>
			<li class="item01"><a href="#" class="on">전체</a></li>
			<li><a href='#' data-car='10'>휘발유</a></li><li><a href='#' data-car='11'>경유</a></li><li class='item01'><a href='#' data-car='12'>LPG</a></li><li><a href='#' data-car='70'>경유/LPG</a></li><li><a href='#' data-car='71'>휘발유/LPG</a></li>		
		</ul>
	</div>	
	<div class="smart_mbTxt">
		<p>제주에서의 행복한 여행과 추억! <br />쉽고 빠른 온라인예약으로 즐겁고 편안한 여행 되세요!</p>
		<ul>
			<li>01 차량대여 조건 : 운전경력 만 1년 이상 운전자만 가능</li>
			<li>02 차량 인수 및 반납 장소 : 제주공항 렌터카 하우스</li>
			<!--<li>03 실시간 예약은 현재일 기준 30일 이후 출발건만 예약이 가능합니다.</li>-->
		</ul>
	</div>
</div>
<!--  //smart search e -->
 
<!-- contents S -->
<div id="contentsWrap">
 
<!-- dBody S -->
<div id="dBody" class="smartS_none ">
 
<div id="contents" class="img_rent01">
	<h2><img src="images/title/titH2_rent.png" alt="차량대여" /></h2>
	<p class="txtPara_coment"><img src="images/contents/txt_rent01_01.png" alt="좌측의 해피 SMART search에서 대여일과 반납일을 선택하신 후 검색버튼을 클릭하세요." /></p>
	<p class="txtPara_tit"><img src="images/contents/txt_rent01_02.png" alt="쉽고 빠른 온라인예약으로 즐겁고 편안한 여행 되세요!" /></p>
	<ol class="olList_type01">
		<li><img src="images/icon/num01.png" alt="01" />차량대여 조건 : 만 21세 이상, 운전경력 만1년 이상 운전자만 가능하며<BR>도로교통법상 유효한 운전면허증 소지자 분만 예약이 가능합니다.</li>
		<li><img src="images/icon/num02.png" alt="02" />차량 인수 및 반납 장소 : 제주공항 렌터카 하우스</li>
		<!--<li><img src="images/icon/num03.png" alt="03" />실시간 예약은 현재일 기준 30일 이후 출발건만 예약이 가능합니다.</li>-->
	</ol>
 
	<ul class="imgPara_rent01">
		<li><img src="images/contents/img_rent01_01.png" alt="" /> <br /><span>차량 검색</span></li>
		<li><img src="images/contents/img_rent01_02.png" alt="" /> <br /> <span>예약정보 입력</span></li>
		<li><img src="images/contents/img_rent01_03.png" alt="" /> <br /> <span>예약정보 확인</span></li>
		<li><img src="images/contents/img_rent01_04.png" alt="" />  <br /><span>예약완료</span></li>
	</ul>
</div>
 
</div>
<!-- dBody E -->
 
</div>
<!-- contents E -->
 
 
 
 
 
<script type="text/javascript">
    $(function () {
        $("#div_notice_onin").show();
    });
    
    function div_close2_In() {
        set_cookie("ckOnlyCarIn", "1", 24);
        div_only_close_In();
    }
    function div_only_close_In() {
        document.getElementById('div_notice_onin').style.display = "none";
    }
 
</script>   <!-- BODY -->
   <hr />
 
</div>
    
</body>
 
 
 
 
------------------------------------------------------------------------------------------------------------
 
 
 
hqppyrent.co.kr.contentsWrap.jsp
 
 
 
<body style="opacity:0;">
 
<!-- contents S -->
<div id="contentsWrap" style="display: block;">
 
<!-- dBody S -->
<div id="dBody" class="smartS_none ">
 
<div id="contents">
<h2><img src="images/title/titH2_rent.png" alt="차량대여"></h2>
<p class="rent_titComent">
	고객님께서 선택하신 기간은 <strong>실시간예약</strong>이 가능한 구간 입니다. <br>실시간 예약을 원하지 않으시거나 예약 가능한 차량이 없을 경우 <strong>예약상담</strong>으로 접수 하시기 바랍니다.</p>
 
<ul class="rent_listShort">
	<li><span>보기방식</span>
		<a href="#" class="btn_short " data-type="view_type" data-val="1"><span>이미지</span></a>
		<a href="#" class="btn_short on" data-type="view_type" data-val="2"><span>텍스트</span></a>
	</li>
	<li><span>실시간예약</span>		
		<a href="#" class="btn_short on" data-type="canUse" data-val="0"><span>전체차량</span></a>		
		<a href="#" class="btn_short " data-type="canUse" data-val="1"><span>가능차량</span></a>
	</li>
	<li id="view_type_charge" style="display:none;"><span>요금제</span>
		<a href="#" class="btn_short " data-type="car_charge" data-val="1"><span>전체요금</span></a>
		<a href="#" class="btn_short on" data-type="car_charge" data-val="2"><span>현재요금</span></a>
	</li>
</ul>
 
<!-- <ul class="rentCar_list  " id="view_type_image" style="display:none;">
		<li>
		<div class="item">
			<span class="photo"><img src="images/goods/car/1/list.png" width="195" height="150" alt=""></span>
			<span class="kind">올뉴모닝</span>
			<div class="liOver_block">
				<p class="btn" data-car="1">
					<a href="#reservPage" class="btn_reserv reservActive">실시간 예약</a><a href="#advicePage" class="btn_reserv adviceActive">예약상담</a>
					<a href="#itemPage" class="btn_rentView btn_triger detailActive">상세 정보 보기</a>
				</p>
			</div>
		</div>
		<ul class="car_charge_1 type03" style="display:none;">
			<li class="price01">정요금<br>150,000원</li>
			<li class="price02"><span>폭풍 </span>: <del>10,000원<span></span></del></li>
			<li class="price03"><span>특가 </span>: <del>12,000원<span></span></del></li>
			<li class="price04"><span>할인 </span>: 14,000원<span>(1)</span></li>
		</ul>
		<ul class="car_charge_2 type03" style="display:;">
			<li class="price05">할인 : <strong>14,000원</strong>(1)</li>
			<li class="price06 ">(90%할인)</li>
		</ul>
		<ul class="car_charge_m">
			<li>할인 : <strong>14,000원</strong>(1)</li>			
		</ul>
	</li>
		<li>
		<div class="item">
			<span class="photo"><img src="images/goods/car/2/list.png" width="195" height="150" alt=""></span>
			<span class="kind">레이</span>
			<div class="liOver_block">
				<p class="btn" data-car="2">
					<a href="#reservPage" class="btn_reserv reservActive">실시간 예약</a><a href="#advicePage" class="btn_reserv adviceActive">예약상담</a>
					<a href="#itemPage" class="btn_rentView btn_triger detailActive">상세 정보 보기</a>
				</p>
			</div>
		</div>
		<ul class="car_charge_1 type03" style="display:none;">
			<li class="price01">정요금<br>150,000원</li>
			<li class="price02"><span>폭풍 </span>: <del>11,000원<span></span></del></li>
			<li class="price03"><span>특가 </span>: <del>13,000원<span></span></del></li>
			<li class="price04"><span>할인 </span>: 15,000원<span>(3)</span></li>
		</ul>
		<ul class="car_charge_2 type03" style="display:;">
			<li class="price05">할인 : <strong>15,000원</strong>(3)</li>
			<li class="price06 ">(90%할인)</li>
		</ul>
		<ul class="car_charge_m">
			<li>할인 : <strong>15,000원</strong>(3)</li>			
		</ul>
	</li>
		<li>
		<div class="item">
			<span class="photo"><img src="images/goods/car/3/list.png" width="195" height="150" alt=""></span>
			<span class="kind">레이 (금연)</span>
			<div class="liOver_block">
				<p class="btn" data-car="3">
					<a href="#reservPage" class="btn_reserv end">실시간 마감</a><a href="#advicePage" class="btn_reserv adviceActive">예약상담</a>
					<a href="#itemPage" class="btn_rentView btn_triger detailActive">상세 정보 보기</a>
				</p>
			</div>
		</div>
		<ul class="car_charge_1 type03" style="display:none;">
			<li class="price01">정요금<br>150,000원</li>
			<li class="price02"><span>폭풍 </span>: <del>12,000원<span></span></del></li>
			<li class="price03"><span>특가 </span>: <del>14,000원<span></span></del></li>
			<li class="price04"><span>할인 </span>: 16,000원<span>(0)</span></li>
		</ul>
		<ul class="car_charge_2 type03" style="display:;">
			<li class="price05">할인 : <strong>16,000원</strong>(0)</li>
			<li class="price06 ">(89%할인)</li>
		</ul>
		<ul class="car_charge_m">
			<li>할인 : <strong>16,000원</strong>(0)</li>			
		</ul>
	</li>
		<li>
		<div class="item">
			<span class="photo"><img src="images/goods/car/5/list.png" width="195" height="150" alt=""></span>
			<span class="kind">뉴모닝LPG</span>
			<div class="liOver_block">
				<p class="btn" data-car="5">
					<a href="#reservPage" class="btn_reserv reservActive">실시간 예약</a><a href="#advicePage" class="btn_reserv adviceActive">예약상담</a>
					<a href="#itemPage" class="btn_rentView btn_triger detailActive">상세 정보 보기</a>
				</p>
			</div>
		</div>
		<ul class="car_charge_1 type03" style="display:none;">
			<li class="price01">정요금<br>150,000원</li>
			<li class="price02"><span>폭풍 </span>: <del>10,000원<span></span></del></li>
			<li class="price03"><span>특가 </span>: <del>12,000원<span></span></del></li>
			<li class="price04"><span>할인 </span>: 14,000원<span>(2)</span></li>
		</ul>
		<ul class="car_charge_2 type03" style="display:;">
			<li class="price05">할인 : <strong>14,000원</strong>(2)</li>
			<li class="price06 ">(90%할인)</li>
		</ul>
		<ul class="car_charge_m">
			<li>할인 : <strong>14,000원</strong>(2)</li>			
		</ul>
	</li>
		<li>
		<div class="item">
			<span class="photo"><img src="images/goods/car/57/list.png" width="195" height="150" alt=""></span>
			<span class="kind">올뉴모닝 (금연)</span>
			<div class="liOver_block">
				<p class="btn" data-car="57">
					<a href="#reservPage" class="btn_reserv reservActive">실시간 예약</a><a href="#advicePage" class="btn_reserv adviceActive">예약상담</a>
					<a href="#itemPage" class="btn_rentView btn_triger detailActive">상세 정보 보기</a>
				</p>
			</div>
		</div>
		<ul class="car_charge_1 type03" style="display:none;">
			<li class="price01">정요금<br>150,000원</li>
			<li class="price02"><span>폭풍 </span>: <del>10,000원<span></span></del></li>
			<li class="price03"><span>특가 </span>: <del>12,000원<span></span></del></li>
			<li class="price04"><span>할인 </span>: 14,000원<span>(2)</span></li>
		</ul>
		<ul class="car_charge_2 type03" style="display:;">
			<li class="price05">할인 : <strong>14,000원</strong>(2)</li>
			<li class="price06 ">(90%할인)</li>
		</ul>
		<ul class="car_charge_m">
			<li>할인 : <strong>14,000원</strong>(2)</li>			
		</ul>
	</li>
		
	</ul> -->
 
<table class="data_tableW" id="view_type_text" cellpadding="0" cellspacing="0" style="display:;">
	<caption></caption>
	<colgroup>
		<col width="">
		<col width="">
	</colgroup>
	<thead>
	<tr>
		<th scope="col">차종</th>
		<th scope="col">차량명</th>
		<th scope="col">정요금</th>
		<th scope="col">폭풍할인</th>
		<th scope="col">특가할인</th>
		<th scope="col">일반할인</th>
		<th scope="col">연료</th>
		<th scope="col">연비</th>
		<th scope="col">인원</th>
	</tr>
	</thead>
	<tbody>
	  <c:forEach items="${result}" var="list">
		<tr class="type03">
		<td>${list.name_cartype}</td>
		<td class="cell_type01 viewBtn">
			<a href="#text" class="">${list.carname}</a>
			<span class="toltip">
				<em>
					- 완전자차요금 무료 <br>
					- 완전자차요금 무료 <br>
					- 편의장비대여료 50% 환불
				</em>
			</span>
		</td>
		<td>${list.normalcost}원</td>
		<td class="price02"><del>10,000원<span></span></del></td>
		<td class="price03"><del>12,000원<span></span></del></td>
		<td class="price04">14,000원<span>(1)</span></td>
		<td>${list.name_fuel}</td>
		<td>${list.name_fuelcost}</td>
		<td>5</td>
	    </tr>
      </c:forEach>
	</tbody>
</table>
</div>
 
<!-- layerNavi_con S -->
<div id="layerNavi">
	<div class="layer_con page_conEl" id="itemPage"> <!-- 상세 정보 보기 -->				
	</div>
 
	<div class="layer_con page_conEl" id="reservPage"> <!-- 실시간 예약 -->				
	</div>
 
	<div class="layer_con page_conEl" id="advicePage"> <!-- 예약상담신청 -->
	</div>
</div>
<!-- layerNavi_con E -->
 
</div>
<!-- dBody E -->
 
</div>
<!-- contents E -->
 
</body>
 
 
 
 
-------------------------------------------------------------------------------------
 
 
 
@Controller
public class HappyrentController {
 
	@Resource(name = "happyrentDAO")
	private HappyrentDAO happyrentDAO;
	
	@RequestMapping(value="/happyrent.do", method=RequestMethod.GET)
	public String happyRent(Model model) throws Exception {
		return "/happyrent/happyrent.co.kr";
	}
	
	@RequestMapping(value="/happyrentWrap.do", method=RequestMethod.POST)
	public String happyRentWrap(Model model, HttpServletRequest request) throws Exception {
		HashMap<String, Object> params = getParams(request);
		model.addAttribute("result", happyrentDAO.selectSampleList(params));
		return "/happyrent/happyrent.co.kr.contentsWrap";
	}
	
	public HashMap<String, Object> getParams(HttpServletRequest request) throws Exception {
		Enumeration enumber = request.getParameterNames();
		HashMap<String, Object> params = new HashMap<String, Object>();
		while (enumber.hasMoreElements()) {
			String key = enumber.nextElement().toString();
			String value = request.getParameter(key);
			System.out.println("log.enumber.hasMoreElements key :"  +  key + " : " + value);
			params.put(key, value);  
		}
		return params;
	}
	
}