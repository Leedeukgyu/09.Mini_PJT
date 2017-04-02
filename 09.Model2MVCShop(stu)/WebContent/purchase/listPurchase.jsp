<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>
<meta charset="EUC-KR">
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncGetAllList(currentPage){
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
   	//document.detailForm.submit();	
	console.log( "/purchase/listPurcase?menu=search");
	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?menu=search").submit();
}
$(function(){

	$("td span.getUser").on("click",function(){
			
		self.location="/user/getUser?userId="+$(this).attr("sendValue");
	});
	
	$("td span.getPurchase").on("click",function(){
		$("td span.getPurchase").css("color","green");
		self.location="/purchase/getPurchase?tranNo="+$(this).attr("sendValue");
	});
	
	$("td span.updateTranCode").on("click",function(){
		alert("���ǵ���");
		$("td span.updateTranCode").css("color","green");
		self.location="/purchase/updateTranCode?tranNo="+$(this).attr("tranNo")+"&tranCode="+$(this).attr("tranCode");
	});
	
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	
	//==> �Ʒ��� ���� ������ ������ ??
	//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No
		<h7>(No click : ������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

			<c:set var="i" value="0" />
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
				
					<td align="center">
					<span class="getPurchase" sendValue="${purchase.tranNo}">
					${i}
					</span>
					</td>
					
					<td></td>
					
					<td align="left">
					<span class="getUser" sendValue="${purchase.buyer.userId }">
					${purchase.buyer.userId}
					</span>
					</td>
					
					<td></td>
					<td align="left">${purchase.receiverName}</td>
					<td></td>
					<td align="left">${purchase.receiverPhone}</td>
					<td></td>
					<td align="left">
					${purchase.tranCode}
					
						<c:choose>
							<c:when test="${purchase.tranCode.trim()=='1'}">���� ���ſϷ� �����Դϴ�.</c:when>
							<c:when test="${purchase.tranCode.trim()=='2'}">���� ����� �����Դϴ�.
							<span class="updateTranCode" tranNo="${purchase.tranNo}" tranCode="${purchase.tranCode}">
							
							���ǵ���
							</span>
							</c:when>
							<c:when test="${purchase.tranCode.trim()=='3'}">���� ��ۿϷ� �����Դϴ�.</c:when>
						</c:choose>
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				</c:forEach>
		</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
				   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
<!-- 		 
			<a href="/listPurchase.do?page=1">1</a> 
		 
			<a href="/listPurchase.do?page=2">2</a> 
			 -->			
			<jsp:include page="../common/pageNavigator.jsp"/>	
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>