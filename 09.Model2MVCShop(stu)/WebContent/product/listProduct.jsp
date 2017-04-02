<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>��ǰ �����ȸ</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
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
	 
	//==> �˻� Event ����ó���κ�
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
	 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
		fncGetAllList(1);
	});
			//==> userId LINK Event ����ó��
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
	$( ".ct_list_pop td:nth-child(3) span" ).on("click" , function() {
			//Debug..
			alert(  $( this).attr('sendValue') );
			alert(  $( this).attr('sendValue2') );
			
			self.location ="/product/getProduct?prodNo="+$(this).attr('sendValue')+"&menu="+$(this).attr('sendValue2');
	});

	/////////////////////////
	 $( ".ct_list_pop td:nth-child(9):contains('����ϱ�')" ).css("color","green");
	
	$( ".ct_list_pop span.prodStatus:contains('����ϱ�')" ).on("click" , function() {
		//Debug..
		alert(  $(this).attr('sendValue3') );
		alert(  $(this).attr('sendValue4') );
		
		self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).attr('sendValue3')+"&tranCode="+$(this).attr('sendValue4');
	});
	/* <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}  */
	
	////////////////////////

		//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	
	//==> �Ʒ��� ���� ������ ������ ??
	//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
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
							<td width="93%" class="ct_ttl01">��ǰ ����</td>
						</c:if>
						<c:if test="${ param.menu == 'search' }">
							<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
						</c:if>
						</tr>
				</table>
			</td>
			<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
				width="12" height="37" /></td>
		</tr>
	</table>
	<!-- �˻� �κ� -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td align="right"><select name="searchCondition"
				class="ct_input_g" style="width: 80px">
						<option value="0"
						${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
					<option value="1"
						${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
					<option value="2"
						${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
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
							style="padding-top: 3px;">�˻� <!-- 	���������� 1���� ����. -->
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
			<td colspan="11">��ü ${resultPage.totalCount } �Ǽ�, ����
				${resultPage.currentPage} ������</td>
		</tr>
		<tr>
			<td class="ct_list_b" width="100">No</td>
			<td class="ct_line02"></td>
			<!-- 	<td class="ct_list_b" width="150">��ǰ��</td> -->
			<td class="ct_list_b" width="150">��ǰ��<br>
			 <h7>(��ǰ�̸�click:������)</h7>
			</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b" width="150">����</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">�����</td>
			<td class="ct_line02"></td>
			<td class="ct_list_b">�������</td>
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
                  				 �Ǹ���
                   <br />
							</c:when>
							<c:otherwise>
                 					     ������
                      <br />
							</c:otherwise>
						</c:choose>
					</c:if> 
					<span class="prodStatus" sendValue3="${product.prodNo}" sendValue4="${product.proTranCode}">
					<c:if test="${param.menu=='manage'}">
						<c:choose>
							<c:when test="${product.proTranCode.trim()=='0' }">
                				        �Ǹ���
                         <br />
							</c:when>
							<c:when test="${product.proTranCode.trim()=='1' }">
                  				       ���ſϷ�
                       <%--   <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}">����ϱ�</a> --%>
                       				����ϱ�
							</c:when>
							<c:when test="${product.proTranCode.trim()=='2' }">
                  				       �����
                         <br />
							</c:when>
							<c:when test="${product.proTranCode.trim()=='3' }">
                   			         ��ۿϷ�
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
