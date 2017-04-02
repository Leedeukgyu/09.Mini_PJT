package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController(){
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception{
		
		System.out.println("/product/addProduct:GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	/////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////  추가된 부분 //////////
	@RequestMapping( value="addJsonProduct", method=RequestMethod.POST )
	public void getJsonProduct(@RequestBody Product product) throws Exception{

		System.out.println("/addJsonProduct/addProduct : POST");	
		//Business Logic
		productService.addProduct(product);
	}
	//////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product,HttpSession session ) throws Exception{
		System.out.println("/product/addProduct:POST");

		/*FileOutputStream fos;

        byte fileData[] = product.getFile().getBytes();
        fos = new FileOutputStream(session.getServletContext().getRealPath("/") + "images\\uploadFiles\\" + product.getFileName());
        fos.write(fileData);

        fos.close();*/
		MultipartFile file=product.getFile();
		if(file !=null){
			String fileName=file.getOriginalFilename();
			product.setFileName(fileName);
			
			File filetemp=new File(session.getServletContext().getRealPath("/")+"images\\uploadFiles\\" + product.getFileName());
		}
		productService.addProduct(product);
		
		return "forward:/product/addProductResult.jsp";
	}
	@RequestMapping(value="getProduct",method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo,@RequestParam ("menu")String menu , Model model)throws Exception{
		
		System.out.println("/product/getProduct:GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model과 View의 연결 model.add~~해서 데이터를 저장해주면 jsp 즉,View 에서 받아먹을수있다.
		model.addAttribute("product", product);
		
		if(menu.equals("search")){
		return "forward:/product/getProduct.jsp";
		}else{
			return "forward:/product/updateProductView.jsp";
		}
	}
	//////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////  추가된 부분 //////////
	@RequestMapping( value="getJsonProduct/{prodNo}", method=RequestMethod.GET )
	public void getJsonProduct(	@PathVariable int prodNo, 
											Model model) throws Exception{

		System.out.println("/getJsonProduct/getProduct : GET");	
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
	}
	//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
	@RequestMapping( value="updatePrododuct", method=RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") int prodNo,Model model)throws Exception{
		
		System.out.println("/product/updateProduct:GET");
		//Business Logic
		Product product=productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	@RequestMapping(value="updateProduct",method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product,Model model) throws Exception{
		
		System.out.println("/product/updateProduct:POST");
		
		productService.updateProduct(product);
		
		Product product2 =productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product2);
		
		return "forward:/product/getProduct.jsp";
	}
	@RequestMapping(value="listProduct")
	public String listProduct(@ModelAttribute("search")Search search,Model model,@RequestParam ("menu")String menu, HttpServletRequest request)throws Exception{
		
		System.out.println("/product/listProduct:GET/POST");
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String,Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";	
	}
}
