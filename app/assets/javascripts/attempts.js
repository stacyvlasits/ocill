function moveScroller() {
    var move = function() {
            var doc = $(document);
        if (doc.height() > 1800) {

            var st = doc.scrollTop();
            var sa = $("#scroller-anchor")
            var ot = sa.offset().top;
            var s = $("#scroller");
            if ( s.height() > ( doc.height() / 2) ) {
              s.css({ 
                "height": doc.height()/2,
                "overflow": "scroll"
              });
            }
            if(st > ot) {
                s.css({
                    "position": "fixed",
                    "top": "40px",
                    "z-index": 5
                });
                sa.css({"height": s.css("height")});
            } else {
                if(st <= ot) {
                    s.css({
                        "position": "relative",
                        "top": "0px",
                        "z-index": 1
                    });
                sa.css({"height": 0 });
                }
            }
            console.log({
                "st": st,
                "ot": ot,
                "doc height": doc.height(),
                "sa": sa.css("height"),
            });
        }
    };
    $(document).scroll(move);
    move();
}

jQuery( document ).ready(function( $ ) {
    var scroller = $("#scroller");
    $("<a/>", {
        "class": "hider",
        text: "Hide Prompt",
        click: function(){
            scroller.toggleClass("see-thru");
            if ( $( this ).text() == "Hide Prompt" ){
               $( this ).text("Show Prompt");
            } else {
                $( this ).text("Hide Prompt");
            }
        }
    }).prependTo(scroller);

    if ( $("#scroller").length ){
        moveScroller();
    }    
});
