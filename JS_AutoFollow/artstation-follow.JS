//	arstation.com Search and Follow
//	btn btn-primary btn-xs

var buttons = document.getElementsByClassName('btn-primary');
for(var i = 0; i < buttons.length; i++)
{	
	//	Follow back
	if( ("Follow" == buttons[i].innerText ) || ("Follow back" == buttons[i].innerText ) )
	{
		buttons[i].click();
	}else{
		setTimeout(() => { console.log("already friends"); }, 1000 );
	}
}