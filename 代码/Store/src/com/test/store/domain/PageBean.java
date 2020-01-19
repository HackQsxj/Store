package com.test.store.domain;

import java.util.List;

public class PageBean<T> {

	private int pageNumber; //当前页
	private int pageSize;
	private int totalRecord; 
	private int totalPage;
	private int startIndex; //开始索引
	private int prePageNum;//上一页						    *
	private int nextPageNum;//下一页
	//一共每页显示9个页码按钮
    private int startPage;//开始页码
	private int endPage;//结束页码
	private List<T> list; //分页数据
	
	//完善属性
	private String path;
	
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getPrePageNum() {
		return prePageNum;
	}
	public void setPrePageNum(int prePageNum) {
		this.prePageNum = prePageNum;
	}
	public int getNextPageNum() {
		return nextPageNum;
	}
	public void setNextPageNum(int nextPageNum) {
		this.nextPageNum = nextPageNum;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public PageBean() {
		super();
		
	}
	public PageBean(int pageNumber, int pageSize, int totalRecord) {
		super();
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
		this.totalRecord = totalRecord;
		
//		成员变量与局部变量重名，此处统一使用成员变量，都需要添加"this"
//		总分页数
		this.totalPage = (totalRecord%pageSize==0)?(totalRecord/pageSize):(totalRecord/pageSize+1);
//		开始索引
		this.startIndex = (this.pageNumber-1)*pageSize;
		if(pageNumber==1){
			prePageNum=1;
		}else{
			prePageNum=pageNumber-1;
		}
		
		if(pageNumber==totalPage){
			nextPageNum=totalPage;
		}else{
			nextPageNum=pageNumber+1;
		}
		
		
		//计算开始页码结束页码
		startPage=pageNumber-4;
		endPage=pageNumber+4;
		
		//如果总页数大于9页
		if(totalPage>9){
			// 如果总页数50页
			// 当前页:第10页    startPage=6 endPage=14
			// 当前页:第3页      startPage=1 endPage=9
			// 当前页:第4页      startPage=1 endPage=9
			// 当前页:第48页    startPage=42 endPage=50
			// 当前页:第46页    startPage=42 endPage=50
			if(startPage<=0){
				startPage=1;
				endPage=startPage+8;
			}
			if(endPage>totalPage){
				endPage=totalPage;
				startPage=totalPage-8;
			}
		}else{
			//如果总页数小于9页
			startPage=1;
			endPage=totalPage;
		}
	}
	
}
