
document.addEventListener('turbolinks:load', function() {



    function preloader(float,size,spinner,classes) {
        float = typeof float !== 'undefined' ? float : 'left';
        size = typeof size !== 'undefined' ? size : 'small';
        spinner = typeof spinner !== 'undefined' ? spinner : 'spinner-green-only';
        classes = typeof classes !== 'undefined' ? classes : 'preloader';
        var preloarder = '';
        preloarder = '<div class="preloader-wrapper '+ size + ' ' + classes + ' ' + float +' active">' +
            '<div class="spinner-layer '+ spinner +'"><div class="circle-clipper left"> <div class="circle"></div> </div><div class="gap-patch"> <div class="circle"></div> </div><div class="circle-clipper right"> <div class="circle"></div> </div> </div> </div>';

        return preloarder
    }


    $('.materialboxed').materialbox();

    $('.button-collapse').sideNav({
            menuWidth: 300, // Default is 300
            edge: 'right', // Choose the horizontal origin
            hover: true,
            closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
            draggable: true // Choose whether you can drag to open on touch screens
        }
    );

    $('.chips').material_chip();
    $('.chips-static-phone').material_chip({
        placeholder: 'تلفن ثابت',
        secondaryPlaceholder: 'تلفن ثابت'
    });

    $('.dropdown-button').dropdown({
            inDuration: 300,
            outDuration: 225,
            constrainWidth: false, // Does not change width of dropdown to that of the activator
            hover: true, // Activate on hover
            gutter: 0, // Spacing from edge
            belowOrigin: false, // Displays dropdown below the button
            alignment: 'left', // Displays dropdown with edge aligned to the left of button
            stopPropagation: false // Stops event propagation
        }
    );

    $('ul.tabs').tabs();
    $('.modal').modal({
        startingTop: '1%', // Starting top style attribute
        endingTop: '1%'
    });

//    Fix menu

    $(window).bind('scroll', function () {
        if ($(window).scrollTop() > 50) {

$('#fix-menu-bar').slideDown();
        } else {
            $('#fix-menu-bar').slideUp();
        }
    });


    $('.carousel').carousel({duration: 1000});
    $('.materialboxed').materialbox();


    $('.report_comment').click(function(e){
        e.preventDefault();
        var id = $(this).attr('id');
        $(this).hide();
        $(this).after(preloader(size='small',float='left',spinner='spinner-green-only',classes='comment_preloader'));
        setTimeout(function(){
        $('.comment_preloader').after('<span class="orange-text left">گزارش شد</span>');
        $('.comment_preloader').remove();

        },4000)

    });

$('.load_more_comment').click(function(e){
    e.preventDefault();
$(this).append(preloader(size='small',float='left',spinner='spinner-red-only',classes='btn-preloader'));
});

$('.add_comment').click(function(e){
e.preventDefault();
$('.SendMessageForm').slideDown();
});



    var ratings = document.getElementsByClassName('rating');

    for (var i = 0; i < ratings.length; i++) {
        var r = new SimpleStarRating(ratings[i]);

        ratings[i].addEventListener('rate', function(e) {
            var ex_id=$(ratings).attr('exposition_id');
            
            console.log('Rating: ' + e.detail);
            $.ajax({
            url: "/exposition/rate/",
            method: "GET",
            data:   'exposition_id='+ex_id+'&vote='+e.detail,
            dataType: "html"
            }).success(function( res ) {
                 Materialize.toast('امتیاز شما ثبت شد',4000,'blue');
                console.log(res);
                $(ratings).attr('disabled','disabled');
            })
        
        });
    }
   
   
   
   $('.product-favorite').click(function(e){
       
       var product_id=$(this).data('id');
       var liked=$(this).attr('liked');
       var like_btn=$(this);
       like_btn.attr('disabled',true);
        $.ajax({
            url: "/product/favorite/",
            method: "GET",
            data:   'id='+product_id+'&liked='+liked,
            dataType: "html"
        }).success(function( res ) {
            if(res=='true'){
                Materialize.toast('محصول به علاقه مندی ها اضافه شد',4000,'blue');
                
                like_btn.removeClass('red');
                like_btn.addClass('blue');
                
            }else{
                Materialize.toast('محصول از علاقه مندی ها حذف شد',4000,'blue');
                
                like_btn.removeClass('blue');
                like_btn.addClass('red');  
                
            }
            like_btn.attr('liked',res);
        }).fail(function(msg){
             console.log(msg)
              Materialize.toast('اشکال در پسندیدن',4000,'blue');
        }).complete(function(){
            like_btn.attr('disabled',false);     
        });
       
       
       
       
       
       
       
       
   })
   
   $('.exposition-follow').click(function(e){
       e.preventDefault();
       
       var exposition_id=$(this).data('id');
       var followed=$(this).attr('followed');
       var flw_btn=$(this);
       flw_btn.attr('disabled',true);
        $.ajax({
            url: "/exposition/follow/",
            method: "GET",
            data:   'id='+exposition_id+'&followed='+followed,
            dataType: "html"
        }).success(function( res ) {
            if(res=='true'){
                Materialize.toast('فروشگاه به لیست فالورها اضافه شد',4000,'blue');
                
                flw_btn.removeClass('red');
                flw_btn.addClass('blue');
                flw_btn.find('i').html('person');
                 flw_btn.find('span').html('حذف از لیست دنبال شدگان');
            }else{
                Materialize.toast('فروشگاه از لیست فالوینگ ها حذف شد',4000,'blue');
                
                flw_btn.removeClass('blue');
                flw_btn.addClass('red');  
                flw_btn.find('i').html('person_add');
                flw_btn.find('span').html('دنبال کردن فروشـــــگاه');
            }
            flw_btn.attr('followed',res);
        }).fail(function(msg){
             console.log(msg)
              Materialize.toast('اشکال در فالو',4000,'blue');
        }).complete(function(){
            flw_btn.attr('disabled',false);     
        });
       
       
       
       
   })
    
});
