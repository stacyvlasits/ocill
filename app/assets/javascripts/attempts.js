function moveScroller() {
    var move = function() {
    	var win = $(window);
        var st = win.scrollTop();
        var sa = $("#scroller-anchor")
        var ot = sa.offset().top;
        var s = $("#scroller");
        if ( s.height() > ( win.height() / 2) ) {
        	s.css({ 
        		"height": win.height()/2,
        		"overflow": "scroll"
        	});
        }
        if(st > ot) {
            s.css({
                "position": "fixed",
                "top": "0px",
                "z-index": 5
            });
            sa.css({"height": s.css("height")});
        } else {
            if(st <= ot) {
                s.css({
                    "position": "relative",
                    "top": "",
                    "z-index": 1
                });
            sa.css({"height": 0 });
            }
        }
    };
    $(window).scroll(move);
    move();
}

jQuery( document ).ready(function( $ ) {
  moveScroller();
});
