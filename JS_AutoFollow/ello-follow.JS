//	ello.co Search and Follow
var buttons = document.getElementsByClassName('FollowButton');
for(var i = 0; i < buttons.length; i++)
{	
	if("Follow" == buttons[i].innerText )
	{
		buttons[i].click();
	}else{
		setTimeout(() => { console.log("already friends"); }, 1000 );
	}
}