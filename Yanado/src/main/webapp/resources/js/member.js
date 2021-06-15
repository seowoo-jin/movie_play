

$.ajax({
	url : "memberList",
	method : "GET",
	dataType : "JSON",
	success : function(result){
		grid.resetData(result);
	}
	
})

console.log("dddd");
var grid = new tui.Grid({
	el : document.getElementById('memberGrid'),
			rowHeaders: ['checkbox'],
		      bodyHeight: 500,
		      treeColumnOptions: {
		        name: 'id',
		        useIcon: false,
		        useCascadingCheckbox: true
		      },
		    
	scrollX : false,
		llY : false,
	columns : [ {
		header : 'ID',
		name : 'id',
		sortable: true
	},{
		header : 'PassWord',
		name : 'pw'
	},{
		header : 'Name',
		name : 'name',
		sortable: true
	},{
		header : 'Phone Number',
		name : 'tel'
	},{
		header : 'E-mail',
		name : 'email'
	},{
		header : 'Join Date',
		name : 'joinDate',
		sortable: true
	},{
		header : 'Is Out',
		name : 'isOut',
		sortable: true
	},{
		header : 'Is Pay',
		name : 'isPay',
		sortable: true
	},{
		header : 'Last Login Date',
		editOptions: {
      					 type: 'text'
    				 },
    				 component: {
      name: 'lastLoginDate',
      options: {
        format: 'yyyy-MM-dd'
      }
    },
		sortable: true
	}],
	
		 rowHeaders: ['rowNum','checkbox'],
		 pageOptions: {
		 useClient: true,
		 perPage: 10
		 }
		      
});

var deleteMember=[];
grid.on('check', (ev) => {
  deleteMember[deleteMember.length] = grid.getValue(ev.rowKey,"id");
});

grid.on('uncheck', (ev) => {
   for(var i=0; i<deleteMember.length;i++){
		if(deleteMember[i] === grid.getValue(ev.rowKey,"id")){
			deleteMember.splice(i,1);
		}
	}
});

$("#deleteMembers").on('click', function(){
	
			$.ajax({
				type : "GET",
				url : "memberDelete",
				data : {"members" : deleteMember},
				success : function(returnData){
					console.log("success");
					document.getElementById('article').innerHTML = returnData;
				},
				error:function(){
					console.log("fail");
				}
			})
		})
