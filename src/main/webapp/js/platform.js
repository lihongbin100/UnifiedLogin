/**
 * Created by lihb on 2/6/16.
 */
$(function () {
    $('.tool').tooltip();
    $("#Modal").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
    String.prototype.format = function(args) {
        if (arguments.length>0) {
            var result = this;
            if (arguments.length == 1 && typeof (args) == "object") {
                for (var key in args) {
                    var reg=new RegExp ("({"+key+"})","g");
                    result = result.replace(reg, args[key]);
                }
            }
            else {
                for (var i = 0; i < arguments.length; i++) {
                    if(arguments[i]==undefined)
                    {
                        return "";
                    }
                    else
                    {
                        var reg=new RegExp ("({["+i+"]})","g");
                        result = result.replace(reg, arguments[i]);
                    }
                }
            }
            return result;
        }
        else {
            return this;
        }
    }
});

function showTip(tipText,state) {
    var tip= $('#tip');
    tip.text(tipText);
    tip.removeClass("hidden");
    if(state=="failure"){
        tip.addClass("alert-danger");
    }
    if(state=="success"){
        tip.addClass("alert-success");
    }
    var time = setTimeout(function () {
        tip.addClass("hidden");
        tip.removeClass("alert-success");
        tip.removeClass("alert-danger");
    }, 3000);
}


if(/Android (\d+\.\d+)/.test(navigator.userAgent)){
    var version = parseFloat(RegExp.$1);
    if(version>2.3){
        var phoneScale = parseInt(window.screen.width)/640;
        document.write('<meta name="viewport" content="width=640, minimum-scale = '+ phoneScale +',' +
            ' maximum-scale = '+ phoneScale +', target-densitydpi=device-dpi">');
    }else{
        document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
    }
}else{
    document.write('<meta name="viewport" content="width=640, user-scalable=no, target-densitydpi=device-dpi">');
}
