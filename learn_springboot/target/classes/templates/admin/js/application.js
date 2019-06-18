/* ========================================================
 *
 * Londinium - premium responsive admin template
 *
 * ========================================================
 *
 * File: application.js;
 * Description: General plugins and layout settings.
 * Version: 1.0
 *
 * ======================================================== */


$(function () {


    //===== Add fadeIn animation to dropdown =====//

    $('.dropdown, .btn-group').on('show.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).fadeIn(100);
    });


    //===== Add fadeOut animation to dropdown =====//

    $('.dropdown, .btn-group').on('hide.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).fadeOut(100);
    });



    /* Activate hidden Sparkline */
    $('.collapse').on('shown.bs.collapse', function () {
        $.sparkline_display_visible();
    });



    //===== Collapsible navigation =====//
    var defaultNav = $('.navigation li.active'), parentNav;
    $('.sidebar-wide li:not(.disabled) .expand, .sidebar-narrow .navigation > li ul .expand').collapsible({
        defaultOpen: 'second-level,third-level',
        cssOpen: 'level-opened',
        cssClose: 'level-closed',
        speed: 150,
        toggle: true
    });
    var currItem = $('.navigation  > li.active') , currParent;
    $('.navigation  > li> a:not(.expand)').click(function(){

        if(currParent){
            currParent.removeClass('level-opened').addClass('level-closed');
            currParent.next().slideUp();
            currParent = null;
        }
        if(currItem){
            currItem.removeClass('active');
        }
        currItem = $(this).parent();
        currItem.addClass('active');
        $(this).parent().siblings().removeClass("active");
    })
    $('.navigation  > li > a.expand').click(function() {
        if(currItem){
            currItem.removeClass('active');
        }
        if(currParent&& currParent.get(0) != this){
            currParent.removeClass('level-opened').addClass('level-closed');
            currParent.next().slideUp();
            currParent.parent(".active").siblings().removeClass("active");
        } 
        $(this).parent().siblings().removeClass("active");
        currParent = $(this);
    })
    $('.navigation  > li > ul a').click(function() {
        if(currItem){
            currItem.removeClass('active')
        }
        currItem = $(this).parent();
        currItem.addClass('active');
    })





});