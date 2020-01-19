<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:variable name="common-styles">
	<style type="text/css">
                body,td,th {                
                	background-color: #0;
                }
                html { border: 0px solid gray; }
                body {
                	background-color: #FFFFFF;
                	margin-top: 0px;
                	margin-left: 0px;
                	margin-right: 0px;
                	margin-bottom: 0px;
                }
                a:hover {
                	color: #AF0000;
                	text-decoration: underline;
                }
                a:link{
                	color: #000000;               	               
                }
                .black_12 {
                	font-family: Verdana, Arial, Helvetica, sans-serif;
                	font-size: 12px;
                	color: #000000;
                	text-decoration: none;
                	line-height: 20px;
                }                            
                .black_14 {
                	font-size: 14px;
                	line-height: 25px;
                	color: #000000;
                	font-family: Verdana, Arial, Helvetica, sans-serif;
              	        text-decoration: none;        
                }                                             
                .black_18 {
                	font-family: "宋体";
                	font-size: 18px;
                	font-weight: bold;
                	color: #4f5394;
                	text-decoration: none;
                }                
                .black_24 {
                	font-family: "妤蜂綋_GB2312";
                	font-size: 24px;
                	color: #000000;
                	text-decoration: none;
                }                
                .b9_12 {
                	font-family: Verdana, Arial, Helvetica, sans-serif;
                	font-size: 12px;
                	font-weight: normal;
                	color: #999999;
                	text-decoration: none;                
                }                	        
		.channel {margin-top: 4px}; 		                               	        	                		
                	
                }                                
	</style>
</xsl:variable>

<!-- channel newspaper -->
<xsl:template match="newspaper[@type='channel']">
	<html>
	<head>
		<title></title>
		<xsl:copy-of select="$common-styles"/>
		<style>
			div.newspapertitle { margin-bottom: 12px; border-bottom: 1px dashed silver;  }
		</style>
	</head>
	<body>
	
	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
		<tbody>			   			   		  	  		        
                  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="5">
                      </td>
                    </tr>
                    <tr>
                      <td class="black_14"><strong><xsl:value-of select="title" disable-output-escaping="yes"/></strong></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="#999999" ></td>
                    </tr>
                  </table>  		    		      	      
                  <table width="90%"  border="0" align="center" cellpadding="5" cellspacing="0">	
       	              <tr>
       	               <xsl:if test="channel/image">
       		         <xsl:variable name="imgurl" select="channel/image/url"/>
       		         <xsl:variable name="imgtitle" select="channel/image/title"/>
       		         <xsl:variable name="imglink" select="channel/image/link"/>			  			  
       		         <td class="black_14">
       		           <a href="{$imglink}"><img  src="{$imgurl}" alt="{$imgtitle}" align="bottom"  border="0" /></a>
       		         </td>			  
       		       </xsl:if>			  			  		    		         		        
       	              </tr>
                      <tr>
                        <td height="5" ></td>
                      </tr>
                  </table>
		        		        
  	          <xsl:for-each select="channel/item">
  		     <xsl:sort select="sortKey" data-type="number" order="ascending"/>   		         
                     <table width="90%"  border="0" align="center" cellpadding="5" cellspacing="0">
                       <tr>
                       <xsl:variable name="itemlink" select="link"/>
                         <td class="black_14"><STRONG><A class="black_14"
                         href="{$itemlink}"><xsl:value-of select="title" disable-output-escaping="yes"/></A></STRONG></td>
                       </tr>
                       <tr>
                         <td class="black_14"><SPAN class="black_12"><xsl:value-of select="description"  disable-output-escaping="yes"/></SPAN></td>
                       </tr>
                       <tr>
                         <td  class="black_14"><SPAN class="b9_12">[ <xsl:value-of select="dateDisplay"/> ]</SPAN></td>
                       </tr>
                     </table>  		          		         
                  </xsl:for-each>		       		        	        		                                               		                 
               </tbody>				   		   		   
	   </table>			         									
	</body>
	</html>
</xsl:template>

<!-- single news item -->
<xsl:template match="newspaper[@type='newsitem']">
	<html>
	<head>
	  <title></title>
	  <xsl:copy-of select="$common-styles"/>
	  <style>
	     .newsitemfooter { text-align: right; margin-top: 14px; padding-top: 4px;  }
	  </style>
	</head>
	<body>									  		
	  <table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
	      <tbody>
	        <tr>
                  <td height="5"> </td>
                </tr>
		
		<xsl:for-each select="channel/item">				  		  		  		    	
		      <tr>		    		          
		         <xsl:variable name="itemlink" select="link"/>		        
                         <td height="25" class="black_14" ><STRONG>
                           <a class="black_14" href="{$itemlink}"><xsl:value-of select="title" disable-output-escaping="yes"/></a></STRONG>
                         </td>		        		        			        	      
		      </tr>		     		                           
                      <tr> 
                        <xsl:if test="from">                  
                        <td class="black_12">作者: <SPAN class="b9_12"> <xsl:value-of select="from"/> </SPAN> </td>
                        </xsl:if>
                      </tr>
                      <tr>  
                        <xsl:if test="dateDisplay">
                          <td class="black_12">时间: <SPAN class="b9_12"> [ <xsl:value-of select="dateDisplay"/> ]</SPAN> </td> 
                        </xsl:if>                                             
                      </tr> 
                        		                      
                      <tr>
                        <td height="1" bgcolor="#999999" class="black_14"></td>
                      </tr>                    
                      
                      <tr>
                        <td class="black_14"><SPAN class="black_12"><xsl:value-of select="description"  disable-output-escaping="yes"/></SPAN></td>
                      </tr>  
                                          
                      <tr>
                        <td height="10" ></td>
                      </tr>  
                      
                      <tr>
                        <td height="25" class="black_12" >
                           <a href="{$itemlink}"><font color = "#0000FF">阅读全文</font></a>
                        </td>		        		        			        	      
                      </tr>
                                          
     		      <!-- add link to comments if available -->
     		      <tr>
      		        <td class="newsitemfooter">
		         <xsl:if test="comments">
			 <xsl:variable name="commentlink" select="comments"/>
			   <xsl:variable name="commentimg" select="commentsImage"/>
			   <a href="{$commentlink}"><img src="{$commentimg}" border="0" hspace="6"/></a>
			 </xsl:if>
		        </td>
                      </tr>                      		                  
  		</xsl:for-each>		   		                       				
               </tbody>				   		   		   
	   </table>			                		
           <span class="black_24"></span>	   
	</body>
	</html>
</xsl:template>

</xsl:stylesheet>