$(document).ready(function() {
	
	//hide the add item popup
	$('#addItemPopup').hide();
	
	$('#addNewItemButton').click(
		function()
		{
			showAddNewItemPopup();
		});
		
	$('#closeButton').click(
		function()
		{
			closeAddNewItemPopup();
		});
	
	//initialise sortable lists
	$('.sortable').sortable({
		handle: "#handle",
		placeholder: "sortable-placeholder",
		update: function() {
			
		var data = "";
	    $("#todoListElement #itemText").each(function(i, el){
	            var p = $(el).html().trim();
	            data += "&"+p+"="+i;
	        });
	        
		$.ajax({
		    type: "POST",
		    url: "/users/set_list_item_orderings" + "?&authenticity_token=" + auth_token + data,
		    data: data
		})
		}
	});
});

function showAddNewItemPopup()
{
	$('#addItemPopup').bPopup({
		speed: 100,
        transition: 'slideDown',
		opacity:0.5,
		positionStyle: 'fixed'
	});
}

function closeAddNewItemPopup()
{
	$('#addItemPopup').hide();
}