
function addOptions(b){
    if(b.length>0) {
	var dr = document.getElementById("addopt");
	for(var j = 0; j < b.length; j++) {
	    if(j>0) {
		addOpt(dr,b[j]);
	    }
	}
    }
}

function dropOpt(btn){
    btns = document.getElementsByName('drop');
    if(btns.length < 2) return;
    if(document.getElementById) {
    	tr = btn;
	while (tr.tagName != 'TR') tr = tr.parentNode;
        tr.parentNode.removeChild(tr);
        var ma = document.getElementById("max_answers");
        var ml = ma.options.length;
        ma.options[ml-1] = null;
    }
}

function addOpt(btn,value){
    btns = document.getElementsByName('drop');
    if(btns.length > 20) return;
    if(document.getElementById) {
	tr = btn;
	while (tr.tagName != 'TR') tr = tr.parentNode;
	var newTr = tr.parentNode.insertBefore(tr.cloneNode(true),tr.nextSibling);
	var str;
	thisChilds = newTr.getElementsByTagName('td');
	for (var i = 0; i < thisChilds.length; i++){
	    if (thisChilds[i].className == 'options') {
		str = '<input type="text" id="opt" name="opt" value="'+value+'" maxlength="255">\n';
		str = str + '<input type="button" name="drop" value=" &minus; " onclick="dropOpt(this);">\n';
		str = str + '<input type="button" id="addopt" value=" + " onclick="addOpt(this,\'\');">';
		thisChilds[i].innerHTML = str;
	    }
	}
	var ma = document.getElementById("max_answers");
	var ml = ma.options.length;
	ma.options[ml] = new Option(ml+1,ml+1);
    }
}
