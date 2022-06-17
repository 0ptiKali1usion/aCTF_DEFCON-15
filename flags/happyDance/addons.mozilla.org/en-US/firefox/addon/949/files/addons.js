/* Addons display js */

$(document).ready(ExpandListItem_init);
$(document).ready(CollapseListItem_init);
$(document).ready(ExpandAll_init);
$(document).ready(CollapseAll_init);

function ExpandListItem_init() {
    $("div.expand-listitem").click(function() {
        $(this).parents(".addon-listitem").removeClass("addon-listitem-dense");
        return false;
    });
}

function CollapseListItem_init() {
    $("div.collapse-listitem").click(function() {
        $(this).parents(".addon-listitem").addClass("addon-listitem-dense");
        return false;
    });
}

function ExpandAll_init() {
    $("span.expand-all-listitems").click(function() {
        $("div.addon-listitem").removeClass("addon-listitem-dense");
        return false;
    });
}

function CollapseAll_init() {
    $("span.collapse-all-listitems").click(function() {
        $("div.addon-listitem").addClass("addon-listitem-dense");
        return false;
    });
}

function toggleSBSize(big) {
    var sb = document.getElementById('header-searchbox');
    if (big)
        sb.style.width = '20em;';
    else
        sb.style.width = '10em;';
}

var gPlatform = PLATFORM_WINDOWS;

var PLATFORM_OTHER    = 0;
var PLATFORM_WINDOWS  = 1;
var PLATFORM_LINUX    = 2;
var PLATFORM_MACOSX   = 3;
var PLATFORM_MAC      = 4;

if (navigator.platform.indexOf("Win32") != -1)
  gPlatform = PLATFORM_WINDOWS;
else if (navigator.platform.indexOf("Linux") != -1)
  gPlatform = PLATFORM_LINUX;
else if (navigator.userAgent.indexOf("Mac OS X") != -1)
  gPlatform = PLATFORM_MACOSX;
else if (navigator.userAgent.indexOf("MSIE 5.2") != -1)
  gPlatform = PLATFORM_MACOSX;
else if (navigator.platform.indexOf("Mac") != -1)
  gPlatform = PLATFORM_MAC;
else
  gPlatform = PLATFORM_OTHER;

function getPlatformName()
{
  if (gPlatform == PLATFORM_WINDOWS)
    return "Windows";
  if (gPlatform == PLATFORM_LINUX)
    return "Linux";
  if (gPlatform == PLATFORM_MACOSX)
    return "MacOSX";
  return "Unknown";
}

function getInstallURL(aEvent) {
 
    // The event target might be the link itself or one of its children
    var target = aEvent.target;
    while (target && !target.href)
      target = target.parentNode;
    
    return target && target.href;
}

function install( aEvent, extName, iconURL, extHash)  {   

    if (aEvent.altKey || !window.InstallTrigger)
        return true;

    var url = getInstallURL(aEvent);

    if (url) {

        var params = new Array();

        params[extName] = {
            URL: url,
            IconURL: iconURL,
            toString: function () { return this.URL; }
        };

        // Only add the Hash param if it exists.
        //
        // We optionally add this to params[] because installTrigger
        // will still try to compare a null hash as long as the var is set.
        if (extHash) {
            params[extName].Hash = extHash;
        }

        InstallTrigger.install(params);

        return false;
    }
    return true;
}

function installTheme( aEvent, extName) {
    if(!window.InstallTrigger) 
        return true;
    
    var url = getInstallURL(aEvent);
    if (!url)
        return true;

    InstallTrigger.installChrome(InstallTrigger.SKIN,url,extName);

    try {
        var p = new XMLHttpRequest();
        p.open("GET", url, true);
        p.send(null);
    } catch(e) { }
    return false;
}

function fixPlatformLinks(addonID, name)
{
    var platform = getPlatformName();
    var outer = document.getElementById("install-"+ addonID);
    var installs = outer.getElementsByTagName("p");
    var found = false;
    for (var i = 0; i < installs.length; i++) {
        var className = installs[i].className;
        if (className.indexOf("platform-" + platform) != -1 ||
            className.indexOf("platform-ALL") != -1) {
                found = true;
        } else {
                installs[i].style.display = "none";
        }
    }
    if (!found)
        outer.appendChild(document.createTextNode(sprintf(addOnNotAvailableForPlatform, name, platform))); 
}

/**
 * replace noscript email by an actual link
 * @param obj id of email node
 * @param lp local part
 * @param hp host part
 */
function emailLink(obj, lp, hp) {
    var cont = document.getElementById(obj);
    var em = lp +'@'+ hp;
    var a = document.createElement('a');
    a.setAttribute('href', 'mailto:'+em);
    a.appendChild(document.createTextNode(em));
    cont.replaceChild(a, cont.lastChild);
}


/**
 * sprintf() implementation for Javascript
 * adapted from public domain code initially published at:
 * http://jan.moesen.nu/code/javascript/sprintf-and-printf-in-javascript/
 */
function sprintf()
{
    if (!arguments || arguments.length < 1 || !RegExp) {
        return null;
    }
    var str = arguments[0];
    var re = /([^%]*)%((\d+)\$)?('.|0|\x20)?(-)?(\d+)?(\.\d+)?(%|b|c|d|u|f|o|s|x|X)(.*)/;
    var a = b = [], numSubstitutions = 0, numMatches = 0;
    
    while ((a = re.exec(str))) {
        var leftpart = a[1], pPos = a[3], pPad = a[4], pJustify = a[5];
        var pMinLength = a[6], pPrecision = a[7], pType = a[8];
        var rightPart = a[9];

        numMatches++;
        if (pType == '%') {
            subst = '%';
        } else {
            if (pPos == '') {
                numSubstitutions++;
                pPos = numSubstitutions;
            }
            if (parseInt(pPos) >= arguments.length) {
                alert('Error! Not enough function arguments (' + (arguments.length - 1)
                    + ', excluding the string)\n'
                    + 'for the number of substitution parameters in string ('
                    + numSubstitutions + ' so far).');
            }
            var param = arguments[parseInt(pPos)];
            var pad = '';
            if (pPad && pPad.substr(0,1) == "'")
                pad = leftpart.substr(1,1);
            else if (pPad)
                pad = pPad;
            var justifyRight = true;
            if (pJustify && pJustify === "-") justifyRight = false;
            var minLength = -1;
            if (pMinLength) minLength = parseInt(pMinLength);
            var precision = -1;
            if (pPrecision && pType == 'f')
                precision = parseInt(pPrecision.substring(1));
            var subst = param;
         
            switch (pType) {
            case 'b':
                subst = parseInt(param).toString(2);
                break;
            case 'c':
                subst = String.fromCharCode(parseInt(param));
                break;
            case 'd':
                subst = parseInt(param) ? parseInt(param) : 0;
                break;
            case 'u':
                subst = Math.abs(param);
                break;
            case 'f':
                subst = (precision > -1)
                    ? Math.round(parseFloat(param) * Math.pow(10, precision))
                    / Math.pow(10, precision)
                    : parseFloat(param);
                break;
            case 'o':
                subst = parseInt(param).toString(8);
                break;
            case 's':
                subst = param;
                break;
            case 'x':
                subst = ('' + parseInt(param).toString(16)).toLowerCase();
                break;
            case 'X':
                subst = ('' + parseInt(param).toString(16)).toUpperCase();
                break;
            }
            var padLeft = minLength - subst.toString().length;
            if (padLeft > 0) {
                var arrTmp = new Array(padLeft+1);
                var padding = arrTmp.join(pad?pad:" ");
            } else {
                var padding = "";
            }
        }
        str = leftpart + padding + subst + rightPart;
    }
    return str;
}
