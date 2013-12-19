function $$(v) {
    
    if (v.substr(0, 1) == "#") {
        v = v.substr(1, v.length - 1);
    }    
    return document.getElementById(v);
}

function $$c(v) {
    return document.createElement(v);
}

function $$q(key) {
    return QueryString(key);
}

function clearSelect(name) {
    $(name).get(0).innerHTML = "";
}

function selectAppend(name, val, text) {
    $(name).append('<option value="' + val + '">' + text + '</option>');
}

function selectRemove(name, optionValue) {
    $(name+" option[value='"+optionValue+"']").remove();
}

/** QUERYSTRING **/
function QueryString(key) {
    var value = null;

    for (var i = 0; i < QueryString.keys.length; i++) {
        if (QueryString.keys[i] == key) {
            value = QueryString.values[i];
            break;
        }
    }
    return value;
}

QueryString.keys = new Array();
QueryString.values = new Array();

function qstring_parse() {
    var query = window.location.search.substring(1);
    var pairs = query.split("&");

    for (var i = 0; i < pairs.length; i++) {
        var pos = pairs[i].indexOf('=');
        if (pos >= 0) {
            var argname = pairs[i].substring(0, pos);
            var value = pairs[i].substring(pos + 1);
            QueryString.keys[QueryString.keys.length] = argname;
            QueryString.values[QueryString.values.length] = value;
        }
    }
}

qstring_parse();