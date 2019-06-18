<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="datatable-footer">

	<ul class="pagination pull-right">
		<li>
			<s:if test="pagination.firstPage == false">
				<a href="javascript:OnPage(1)">&laquo;</a>
			</s:if>
			<s:else>
				<a href="javascript:void(0);">&laquo;</a>
			</s:else>
		</li>
		<s:iterator value="pagination.pageIndexs" status="stat">
			<s:if test="#stat.index == pagination.currentPage - pagination.startPage">
				<li>
					<a href="javascript:void(0);" class="active"> 
						<s:property value="#stat.index + pagination.startPage" /> 
					</a>
				</li>
			</s:if>
			<s:else>
				<li>
					<a href="javascript:OnPage(<s:property value="#stat.index + pagination.startPage" />)">
						<s:property value="#stat.index + pagination.startPage" /> 
					</a>
				</li>
			</s:else>
		</s:iterator>
		<li>
		<s:if test="pagination.lastPage == false">
			<a href="javascript:OnPage(<s:property value="pagination.pageCount"/>)" title="尾页">&raquo;</a>
		</s:if>
		<s:else>
			<a href="javascript:void(0);">&raquo;</a>
		</s:else>
		</li>
	</ul>
</div>


<input type="hidden" name="actionString" id="actionString" value="">
<s:hidden name="pagination.startPage" id="startPage"/>
<s:hidden name="pageIndex" id="currentPage"/>
<input type="hidden" name="orderField" id="orderField"  value="<s:property value="orderField"/>">
<input type="hidden" name="orderType" id="orderType"  value="<s:property value="orderType"/>">
<input type="hidden" name="selectedIds" id="selectedIds" value="" />

<script type="text/javascript">	
    function OnNext() { //到下一页
	    var currentPage = <s:property value="pageIndex" />;
	    $("#currentPage").val(currentPage + 1);
	    $("#actionString").val("page");
	    document.listForm.submit();
	}
	function OnPrevious() {//到前一页
	    var currentPage = <s:property value="pageIndex" />;
	    $("#currentPage").val(currentPage - 1);
	    $("#actionString").val("page");
	    document.listForm.submit();
	}
	function OnPage(pageIndex) {//跳到第几页
		$("#currentPage").val(pageIndex);
	    $("#actionString").val("page");
	    document.listForm.submit();
	}
	function OnGoToPageEvent(evt) {	//回车事件触发跳转到指定页
		var e = evt ? evt : (window.event ? window.event : null);
		if (!e) {
			return;
		}
		var key = 0;
		if (e.keyCode) {
			key = e.keyCode;
		} else {
			if (typeof(e.which) != 'undefined') {
				key = e.which;
			}
		}
		if (key == 13) {
			e.returnValue = false;
			OnGoToPage();
		}
	}
	function OnGoToPage() {	//跳转到指定页
		var totalCount=<s:property value="pagination.pageCount"/>
		var gotoPage = $.trim($("#gotoPage").val());
		if (gotoPage == "") {
			return;
		}
		if(gotoPage>totalCount){
			top.dialog_alert("超过总页数!");
			return;
		}
		if(isNaN(gotoPage)){
			top.dialog_alert("请输入数字!");
			return;
		}
		if(!RegExp(/^(?:0|[1-9][0-9]?|100)$/).test(gotoPage)){
			top.dialog_alert("请输入正整数!");
			return;
		}
		if(gotoPage == 0){
			top.dialog_alert("请输入正确的页数!");
			return;
		}
		OnPage(gotoPage);
	}
</script>