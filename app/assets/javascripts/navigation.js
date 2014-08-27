(function() {
  jQuery(function() {
    
    
   $('.drills').hide();
   $('ul.nav-branch.units').hide();


    $('.units > li a[title="View Drills"]').click(function () {
      $(this).parent().find('ul').toggle(100);
    });
    $('#nav-tree .expand-course').click(function () {
      $(this).next().toggleClass('hidden');
       $(this).parent().children('ul').toggle(100);
      $(this).toggleClass('hidden');
     });
 
    $('#nav-tree .collapse-course').click(function () {
      $(this).prev().toggleClass('hidden');
      // $(this).parent().find('ul').toggle(100);
      $(this).parent().children('ul').toggle(100);
      $(this).toggleClass('hidden');
    });
    $('#nav-tree .expand-unit').click(function () {
      $(this).next().toggleClass('hidden');
      $(this).parent().find('ul').toggle(100);
      $(this).toggleClass('hidden');
    });
    $('#nav-tree .collapse-unit').click(function () {
      $(this).prev().toggleClass('hidden');
      $(this).parent().find('ul').toggle(100);
      $(this).toggleClass('hidden');
    });

     // Read URL to get the item type (drills, units)
    var readURL = window.location.pathname.split('/');
    var whichItem = readURL[2]; // gives you id of unit/drill 
    if(readURL[1]=="drills") {
      // 'attempts' are subfolders of 'drills' in the url, so this way it is a freebie
      $('.drill[data-drill-id="'+whichItem+'"]').parent().parent().parent().show();
      $('.drill[data-drill-id="'+whichItem+'"]').parent().parent().parent().parent().children('.expand-course').toggleClass('hidden');
      $('.drill[data-drill-id="'+whichItem+'"]').parent().parent().parent().parent().children('.collapse-course').toggleClass('hidden');
      
      $('.drill[data-drill-id="'+whichItem+'"]').parent().show();
      $('.drill[data-drill-id="'+whichItem+'"]').parent().parent().children('.expand-unit').toggleClass('hidden');
      $('.drill[data-drill-id="'+whichItem+'"]').parent().parent().children('.collapse-unit').toggleClass('hidden');
    }
    else if(readURL[1]=="units"){
      $('.nav-leaf[data-unit-id="'+whichItem+'"]').parent().show();
      $('.nav-leaf[data-unit-id="'+whichItem+'"]').parent().parent().children('.expand-course').toggleClass('hidden');
      $('.nav-leaf[data-unit-id="'+whichItem+'"]').parent().parent().children('.collapse-course').toggleClass('hidden');

      $('.nav-leaf[data-unit-id="'+whichItem+'"]').children('.expand-unit').toggleClass('hidden');
      $('.nav-leaf[data-unit-id="'+whichItem+'"]').children('.collapse-unit').toggleClass('hidden');
      $('.nav-leaf[data-unit-id="'+whichItem+'"]').children('.drills').show();
    }



    // Removes the 'Successfully created unit/course' notification. 
    var noticeText = $('.notice').text();
    var errorText = $('.error').text();
    var alertText = $('.alert').text();
    $('.notice').empty(); 
    toastr.options = { positionClass: 'toast-top-right' };
    var tempError = errorText.substring(0,13);
    var tempNotice = noticeText.substring(0,18);
    var tempAlert = alertText.substring(0,13);
    if(tempNotice == "Successfully added" || tempError=="Failed to add" || tempAlert=="Failed to add") {
      toastr.options = {
        "onclick":null,
        "timeOut":null,
        "extendedTimeOut": null
      }
    }
    else {
      toastr.options = {
        "timeOut": 5000,
        "extendedTimeOut": 1000
      } 
    }
    if(noticeText!="") { toastr.success(noticeText); } 
    if(errorText!="") { toastr.error(errorText); }
    else if(alertText!="") { toastr.error(alertText); } 
    
    // adds <td> to each row as it needs it to fill
    var numCourses = $('#courses').children('.course-report').length;
    for(var i=1; i<=numCourses;++i) {
      var numChildHead = $('.course-report:nth-child('+i+') thead tr').children('th').length;
      var numTRBody = $('.course-report:nth-child('+i+') tbody').children('tr').length;
      for(var j =0; j <= numTRBody; ++j) {
        //returns num of td in a row
        var startTR = $('.course-report:nth-child('+i+') tbody tr:nth-child('+j+')').children('td').length; 
        while(startTR < numChildHead) {
          $('.course-report:nth-child('+i+') tbody tr:nth-child('+j+')').append("<td></td>");
          ++startTR;
        }
      }
    }

    // resize the nav panel based on the size of the browser window
    var aoeu = window.innerHeight - $('.navbar').height() - 35;
    document.getElementById('nav-tree').style.height = aoeu+"px";

    $(window).resize(function() {
        aoeu = window.innerHeight - $('.navbar').height() - 35;
        var navTree = document.getElementById('nav-tree')
        if (navTree) {
          navTree.style.height = aoeu+"px";
        }
      }
    );

  });
}).call(this);
