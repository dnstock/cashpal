var merchant_array;try{function Merchant(mn,aw,lsu,au,iTIA){this.merchantName=mn;this.searchString=aw;this.trackingRedirectUrl=lsu;this.affiliateType=au;this.isTrackedInAddon=iTIA;};Merchant.prototype.toString=function aW(){return this.merchantName+"|"+this.searchString+"|"+this.trackingRedirectUrl+"|"+this.affiliateType+"|"+this.isTrackedInAddon;};Merchant.prototype.toJSONString=Object.prototype.toJSONString;var merchantprefs=Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefService).getBranch(pref_branch_name+"merchants.");var merchant_global_array_key='merchant_global_array';function getNewMerchantArrayStatic(){var b=[new Merchant("STATIC-DATA-FROM-CACHE","localhost","http://127.0.0.1","dummy"),new Merchant("Buy.com USA and Buy.com CA","buy.com","http://affiliate.buy.com/gateway.aspx?adid=17662&aid=10389736&pid=2972242","CommissionJunction"),new Merchant("Priceline","priceline.com","http://www.anrdoezrs.net/click-2972242-10392970","CommissionJunction"),new Merchant("eBay","ebay.com","http://rover.ebay.com/rover/1/711-53200-19255-0/1?type=1&campid=5335850615&toolid=10001","eBay"),new Merchant("1-800 PetMeds","1800petmeds.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=53794.10000072&type=4&subid=0","Linkshare"),new Merchant("Bare Necessities","barenecessities.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=17019.10001343","Linkshare"),new Merchant("drugstore.com","drugstore.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=43440.10000587","Linkshare"),new Merchant("Florsheim.com","florsheim.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=78067.10000067","Linkshare"),new Merchant("Flower.com","flower.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=102910.10000071","Linkshare"),new Merchant("Fujitsu Computer Systems Corporation","fujitsu.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=130797","Linkshare"),new Merchant("LandscapeUSA.com","landscapeusa.com","http://click.linksynergy.com/fs-bin/stat?id=pewANFyptSw&offerid=4201","Linkshare"),new Merchant("Luggage OnLine","luggageonline.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=81276.10000165&type=3&subid=0","Linkshare"),new Merchant("Lumber Liquidators","lumberliquidators.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=119267","Linkshare"),new Merchant("McAfee, Inc","mcafee.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=50252","Linkshare"),new Merchant("Shutterfly.com","shutterfly.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=146839.10000361&type=3&subid=0","Linkshare"),new Merchant("Tech Depot","techdepot.com","http://click.linksynergy.com/fs-bin/click?id=pewANFyptSw&offerid=41019.10000065","Linkshare")];return b;};if(!hasInSessionStore(merchant_global_array_key)){writeArrayToSessionStore(merchant_global_array_key,getNewMerchantArrayStatic());}function aO(){var m=getArrayFromSessionStore(merchant_global_array_key);return m;};merchant_array=aO();var ak=merchant_array.length;var ad=" ";function refreshMerchants(event){doc=event.target;M_JSON_A=doc.getElementById('json').innerHTML;writeArrayToSessionStore(merchant_global_array_key,nativeJSON.decode(M_JSON_A));merchant_array=aO();r('merchants.js line 119 test of merchant_array(after update): \r\n'+merchant_array[0].merchant.merchantName);};window.addEventListener("load",function(){try{refreshMerchantsBrowser=window_document.getElementById('refreshMerchants');refreshMerchantsBrowser.addEventListener("load",refreshMerchants,true);if(f(merchant_array[0].merchantName,"STATIC-DATA-FROM-CACHE")){refreshMerchantsBrowser.loadURI("http://www.cashaddon.com.nyud.net/addon/refresh_merchants");}}catch(e){r('merchants.js line 145 caught this: '+e);}},false);function ap(M,R,mn,aw,lsu,au){try{var merchant=new Merchant(mn,aw,lsu,au);var av=merchant.toJSONString();writeToSessionStore(M,R,av);}catch(e){}};function getMerchantFromSessionStore(M,R){try{var obj=getFromSessionStore(M,R).parseJSON();var merchant=new Merchant(obj.merchantName,obj.searchString,obj.trackingRedirectUrl,obj.affiliateType);return merchant;}catch(e){}}}catch(e){alert(e);}