
$.ajax({
	url : "video/teaserList",
	method : "GET",
	dataType : "JSON",
	success : function(result){
		grid.resetData(result);
	}
	
})

var grid = new tui.Grid({
	el : document.getElementById('grid'),
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
		header : 'Title',
		name : 'title'
	},{
		header : 'Upload Date',
		name : 'uploadDate'
		
	},{
		header : 'Play on Main',
		name : 'isMain'
	},{
		header : 'Teaser NO.',
		name : 'teaserSeq'
	} ],
	
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


var selectedTeaser=[];
grid.on('check', (ev) => {
  selectedTeaser[selectedTeaser.length] = grid.getValue(ev.rowKey,"teaserSeq");
});

grid.on('uncheck', (ev) => {
   for(var i=0; i<selectedTeaser.length;i++){
		if(selectedTeaser[i] === grid.getValue(ev.rowKey,"teaserSeq")){
			selectedTeaser.splice(i,1);
		}
	}
});

	$("#deleteTeaser").on('click', function(){
	
			$.ajax({
				type : "GET",
				url : "teaserDelete",
				data : {"teasers" : selectedTeaser},
				success : function(returnData){
					console.log("success");
					document.getElementById('article').innerHTML = "admin/member";
				},
				error:function(){
					console.log("fail");
				}
			})
		})
		
	$("#teaserToMain").on('click', function(){
	
			$.ajax({
				type : "GET",
				url : "teaserToMain",
				data : {"teasers" : selectedTeaser},
				success : function(returnData){
					console.log("success");
					document.getElementById('article').innerHTML = "admin/member";
				},
				error:function(){
					console.log("fail");
				}
			})
		})	
		
		
		
		