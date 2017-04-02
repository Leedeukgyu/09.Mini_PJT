<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>상품 목록조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	

function fncGetAllList(currentPage){
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
   	//document.detailForm.submit();	
	console.log( "/product/listProduct?menu=${param.menu}");
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
}
$(function() {
	 
	//==> 검색 Event 연결처리부분
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
	 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
		fncGetAllList(1);
	});
			//==> userId LINK Event 연결처리
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
	$( ".ct_list_pop td:nth-child(3) span" ).on("click" , function() {
			//Debug..
			alert(  $( this).attr('sendValue') );
			alert(  $( this).attr('sendValue2') );
			
			self.location ="/product/getProduct?prodNo="+$(this).attr('sendValue')+"&menu="+$(this).attr('sendValue2');
	});

	/////////////////////////
	 $( ".ct_list_pop td:nth-child(9):contains('배송하기')" ).css("color","green");
	
	$( ".ct_list_pop span.prodStatus:contains('배송하기')" ).on("click" , function() {
		//Debug..
		alert(  $(this).attr('sendValue3') );
		alert(  $(this).attr('sendValue4') );
		
		self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).attr('sendValue3')+"&tranCode="+$(this).attr('sendValue4');
	});
	/* <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}  */
	
	////////////////////////

		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	
	//==> 아래와 같이 정의한 이유는 ??
	//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
	//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
	//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
	//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
	//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
});	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">
	<%-- action="/product/listProduct?menu=${param.menu}" method="post"> --%>
	<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
				width="15" height="37" /></td>
			<td background="/images/ct_ttl_img02.gif" width="100%"
				style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<c:if test="${ param.menu == 'manage' }">
							<td width="93%" class="ct_ttl01">상품 관리</td>
						</c:if>
						<c:if test="${ param.menu == 'search' }">
							<td width="93%" class="ct_ttl01">상품 목록조회</td>
						</c:if>
						</tr>
				</table>
			</td>
			<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
				width="12" height="37" /></td>
		</tr>
	</table>
	<!-- 검색 부분 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td align="right"><select name="searchCondition"
				class="ct_input_g" style="width: 80px">
						<option value="0"
						${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
					<option value="1"
						${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
					<option value="2"
						${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select> <input type="text" name="searchKeyword"
				value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
	class="ct_input_g" style="width: 200px; height: 19px" />
			</td>
				<td align="right" width="70">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23"><img
							src="/images/ct_btnbg01.gif" width="17" height="23"></td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"
							style="padding-top: 3px;">검색 <!-- 	현재페이지 1부터 시작. -->
						</td>
						<td width="14" height="23"><img
							src="/images/ct_btnbg03.gif" width="14" height="23"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td colspan="11">전체 ${resultPage.totalCount } 건수, 현재
				${resultPage.currentPage} 페이지</td>
		</tr>
		<tr>
			<td class="ct_list_b" width="100">No</td>
			<td class="ct_line02"></td>
			<!-- 	<td class="ct_list_b" width="150">상품명</td> -->
			<td class="ct_list_b" width="150">상품명<br>
			 <h7>(상품이름click:상세정보)</h7>
			</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">가격</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">등록일</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">현재상태</td>
		</tr>
		<tr>
			<td colspan="11" bgcolor="808285" height="1"></td>
		</tr>
			<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
				<td align="center">${ i }</td>
				<td></td>
				
				<td align="left">
				<span class="getProduct" sendValue="${product.prodNo}" sendValue2="${ param.menu }">
				<c:if test="${product.proTranCode=='0'}">
						<img src="/images/uploadFiles/${product.fileName}" width="50" />
						
             					${product.prodName}
          					</c:if> 
  				 <c:if test="${product.proTranCode!='0'}">
             
       			${product.prodName}
       			</c:if>
       			</span>
      	 		</td>
			

			<td></td>
			<td align="left">${product.price}</td>
				<td></td>
				<td align="left">${product.regDate}</td>
				<td></td>
				<td align="left">
				<c:if test="${param.menu=='search'}">
				
						<c:choose>
							<c:when test="${product.proTranCode.trim()=='0'}">
                  				 판매중
                   <br />
							</c:when>
							<c:otherwise>
                 					     재고없음
                      <br />
							</c:otherwise>
						</c:choose>
					</c:if> 
					<span class="prodStatus" sendValue3="${product.prodNo}" sendValue4="${product.proTranCode}">
					<c:if test="${param.menu=='manage'}">
						<c:choose>
							<c:when test="${product.proTranCode.trim()=='0' }">
                				        판매중
                         <br />
							</c:when>
							<c:when test="${product.proTranCode.trim()=='1' }">
                  				       구매완료
                       <%--   <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}">배송하기</a> --%>
                       				배송하기
							</c:when>
							<c:when test="${product.proTranCode.trim()=='2' }">
                  				       배송중
                         <br />
							</c:when>
							<c:when test="${product.proTranCode.trim()=='3' }">
                   			         배송완료
       	                    <br />
							</c:when>
						</c:choose>
						
					</c:if>
					</span>
					</td>
					<td></td>
				<!-- </td> -->
			</tr>
			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
		</c:forEach>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td align="center"><input type="hidden" id="currentPage"
				name="currentPage" value="${resultPage.currentPage}" /> <jsp:include
					page="../common/pageNavigator.jsp" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
