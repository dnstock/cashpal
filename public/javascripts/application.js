// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showlogin(e) {
  if(e) {
    document.getElementById("loginbox").style.display = "block";
    document.getElementById("loginbox0").style.display = "none";
    document.getElementById("loginbox00").style.display = "none";
    document.getElementById("loginbox-username").focus()
  }
  else {
    document.getElementById("loginbox").style.display = "none";
    document.getElementById("loginbox0").style.display = "block";
    document.getElementById("loginbox00").style.display = "block";
  }
}

function toggleDIV(div_id){
    var div = document.getElementById(div_id);
    if (div.style.display == 'none') {
        div.style.display = 'block';
    }
    else {
        div.style.display = 'none';
    }
}

// by default the style properties below are reversed
// this function only gets called when/if the addon is detected
function addonInstalled() {
  getElementById("cao-not-installed").style.display="none";
  getElementById("cao-installed").style.display="block";
}

//https://developer.mozilla.org/En/Installing_Extensions_and_Themes_From_Web_Pages

function Obj1(){
}

Obj1.prototype.URL = '';
Obj1.prototype.IconURL = '';
//Obj1.prototype.Hash = '';
Obj1.prototype.toString = function(){
};

function install() {
  extName = 'CashAddOn.com';
  iconURL = 'http://cashaddon.com/images/status-plus.png';
  hash = '';
  var obj1 = new Obj1();
  obj1.URL = "/files/addon/FF3/cashaddon.xpi"
  obj1.IconURL = iconURL;
  obj1.toString = function() {
    return this.URL + " " + this.IconURL + " " + this.Hash;
  };
  var p = new Object();
  p[extName] = obj1;
  var flag = InstallTrigger.install(p);
  if (!flag) {
    document.getElementById("click-allow").style.display = "block"
  }
  return false;
}

