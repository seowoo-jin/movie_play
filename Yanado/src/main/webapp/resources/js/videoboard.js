
$.ajax({
	url : "video/videoList",
	method : "GET",
	dataType : "JSON",
	success : function(result){
		grid.resetData(result);
	}
	
})

console.log("videoboard");
var grid = new tui.Grid({
	el : document.getElementById('videoGrid'),
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
		name : 'title',
		sortable: true
	}, {
		header : 'UniqueNo',
		name : 'uniqueNo',
		sortable: true
	},{
		header : 'Season',
		name : 'season'
	}, {
		header : 'Episode',
		name : 'episode'
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


grid.on('dblclick', (ev) => {
	 var uniqueNo = grid.getValue(ev.rowKey,"uniqueNo");
	 console.log(uniqueNo);
	 
 	 var xhttp = new XMLHttpRequest();
	 xhttp.onreadystatechange = function() {
		if(xhttp.readyState == 4 && xhttp.status == 200){
			if (xhttp.responseText){
				document.getElementById("article").innerHTML = this.responseText;
			}
		}
	};
	xhttp.open("GET", "video/videoRead?uniqueNo="+uniqueNo, true);
	xhttp.send();
})


var deleteVideo=[];
grid.on('check', (ev) => {
  deleteVideo[deleteVideo.length] = grid.getValue(ev.rowKey,"uniqueNo");
});

grid.on('uncheck', (ev) => {
   for(var i=0; i<deleteVideo.length;i++){
		if(deleteVideo[i] === grid.getValue(ev.rowKey,"uniqueNo")){
			deleteVideo.splice(i,1);
		}
	}
});

$("#deleteVideo").on('click', function(){
	
			$.ajax({
				type : "GET",
				url : "videoDelete",
				data : {"videos" : deleteVideo},
				success : function(returnData){
					console.log("success");
					document.getElementById('article').innerHTML = "admin/member";
				},
				error:function(){
					console.log("fail");
				}
			})
		})