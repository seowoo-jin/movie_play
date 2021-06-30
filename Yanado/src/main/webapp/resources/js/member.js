

$.ajax({
	url : "memberList",
	method : "GET",
	dataType : "JSON",
	success : function(result){
		grid.resetData(result);
	}
	
})

var grid = new tui.Grid({
	el : document.getElementById('memberGrid'),
			rowHeaders: ['checkbox'],
		      bodyHeight: 400,
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
	}],
	
		 rowHeaders: ['rowNum','checkbox'],
		 
		 pageOptions: {
		 useClient: true,
		 perPage: 10
		 }
		
});


tui.Grid.applyTheme('default', {
  cell: {
    normal: {
      background: '#747474',
      border: '#747474',
      text: '#DFDEDE',
    },
    head: {
      background: '#747474',
      border: '#747474',
      text: '#DFDEDE',
    },
    rowHead: {
      border: ''
    },
    selectedHead: {
      background: '#747474',
    },
    evenRow: {
      background: '#747474',
    },
    oddRow: {
      background: '#747474'
    }
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
