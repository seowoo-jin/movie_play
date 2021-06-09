
$.ajax({
	url : "video/videoList",
	method : "GET",
	dataType : "JSON",
	success : function(result){
		grid.resetData(result);
	}
	
})

var grid = new tui.Grid({
	el : document.getElementById('grid'),
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
		header : 'Title',
		name : 'title'
	}, {
		header : 'Season',
		name : 'season'
	}, {
		header : 'Episode',
		name : 'episode'
	} ],
	
		 rowHeaders: ['rowNum'],
		 pageOptions: {
		 useClient: true,
		 perPage: 10
		 }
		      
});

grid.on('dblclick', (ev) => {
  console.log(ev.rowKey);
  console.log(ev);
})