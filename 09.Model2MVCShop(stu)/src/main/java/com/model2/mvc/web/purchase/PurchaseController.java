package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="addPurchase",method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		
		System.out.println("/purchase/addPurchase:GET");
		
		Product product=productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	@RequestMapping(value="addPurchase",method=RequestMethod.POST)
	public String addPurchase(@RequestParam("prodNo") int prodNo,@RequestParam("buyerId") String userId,@ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println("/purchase/addPurchasew:POST");
		User user=userService.getUser(userId);
		Product product=productService.getProduct(prodNo);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	@RequestMapping(value="listPurchase")
	public String listPurchase(@ModelAttribute("search")Search search,Model model, HttpSession session)throws Exception{
		
		System.out.println("/purchase/listPurchase:GET/POST");
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		Map<String,Object> map=purchaseService.getPurchaseList(search, sessionId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	@RequestMapping(value="getPurchase",method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo")int tranNo,Model model) throws Exception{
	
		System.out.println("purchase/getPurchase:GET");
		Purchase purchase=purchaseService.getPurchase(tranNo);
		System.out.println(purchase+"+++++++");
		model.addAttribute("purchase", purchase);
		
		
		return "forward:/purchase/getPurchase.jsp";
	}
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	@RequestMapping( value="getJsonPurchase/{tranNo}", method=RequestMethod.GET )
	public void getJsonPurchase(	@PathVariable int tranNo, 
											Model model) throws Exception{

		System.out.println("/getJsonProduct/getProduct : GET");	
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
	}
	//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="updatePurchase",method=RequestMethod.GET)
	public String updatePurchase(@RequestParam("tranNo")int tranNo,Model model) throws Exception{
		System.out.println("purchase/updatePurchase:GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	@RequestMapping(value="updatePurchase",method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase, Model model) throws Exception{
		
		System.out.println("purchase/updatePurchase:POST");
		
		purchaseService.updatePurchase(purchase);
		
		Purchase purchase2=purchaseService.getPurchase(purchase.getTranNo());
		
		model.addAttribute("purchase",purchase2);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping(value="updateTranCodeByProd",method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo")int prodNo,@RequestParam("tranCode")String tranCode) throws Exception{
		
		System.out.println("purchase/updateTranCodeByProd:POST");

	//프로덕트 만들고 그 프로덕트를 다시 펄체스에 지벙넣고 걔를 펄처스 서비스점 업데이트트랜코드로 넘기자
		Purchase purchase=new Purchase();
		purchase=purchaseService.getPurchase2(prodNo);
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/product/listProduct?menu=manage";
	}
	@RequestMapping(value="updateTranCode",method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranNo")int tranNo,@RequestParam("tranCode")String tranCode) throws Exception{
		
		System.out.println("purhcase/updateTrancode:POST");
		System.out.println(tranNo);
		Purchase purchase = new Purchase();
		purchase=purchaseService.getPurchase(tranNo);
		purchaseService.updateTranCode(purchase);
		
		
		return "redirect:/purchase/listPurchase";
	}
}























