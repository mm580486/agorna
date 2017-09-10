//= require jquery
//= require jquery_ujs
//= require materialize
//= require admin/main
//= require_self



$(document).ready(function(){
    
    
        
        $('#sendToMarketer').click(function(){
            var marketer_id=$('#marketer_id').val();
            var seller_id=$('#seller_id').val();
    
    
            $.ajax({
                url: "/admin/sellers/"+seller_id+"/deliver_to_marketer",
                method: "GET",
                data:   'marketer_id='+marketer_id,
                dataType: "html"
            }).success(function( msg ) {
                
                if(msg.status==200){
                    Materialize.toast('کار جدید برای بازاریاب ثبت شد',5000,'green');
                }else{
                    msg['messages']
                    // .forEach(function(entry) {
                        
                    //         Materialize.toast(entry,5000,'red');
                            
                    //     });
                    
                }
                
                
                
            }).fail(function(){
                 
                 Materialize.toast('اشکال در ارسال به بازاریاب',5000,'red');
            })
            
    
    
        });
        
        
        
        $('.b-modal').click(function(e) {
            $('#seller_id').val($(this).attr('sellerId'));
        });
    
    $( "#product_category_id" ).on( "change", function() {
      
      $('div').filter("[categories]").slideUp();
      $("div").find("[categories*='" + $( this ).val() + "']").slideDown()
      
    });
    
        var introguide = introJs();
        introguide.setOptions({ 'nextLabel': 'بعد', 'prevLabel': 'قبل', 'skipLabel': 'خروج', 'doneLabel': 'اتمام' })
        introguide.setOptions({
            steps: [
                {
                  element: '.user_name',
                  intro: 'This guided tour will explain the Hongkiat demo page interface.<br><br>Use the arrow keys for navigation or hit ESC to exit the tour immediately.',
                  position: 'bottom'
                },
                {
                  element: '.nav-logo',
                  intro: 'Click this main logo to view a list of all Hongkiat demos.',
                  position: 'bottom'
                },
                {
                  element: '.nav-title',
                  intro: 'Hover over each title to display a longer description.',
                  position: 'bottom'
                },
                {
                  element: '.readtutorial a',
                  intro: 'Click this orange button to view the tutorial article in a new tab.',
                  position: 'right'
                },
                {
                  element: '.nav-menu',
                  intro: "Each demo will link to the previous & next entries.",
                  position: 'bottom'
                }
            ]
        });
        
        $('#help').click(function(e){
             e.preventDefault();
             introguide.start();
        })
       
    
    
    
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
           $('input#input_text, textarea#textarea1').characterCounter();
        
        $('#development').click(function(){
            var development_mod = $(this).is(':checked');
            
            $.ajax({
                url: "/admin/dashboard/change_development_mode",
                method: "GET",
                data:   'development_mod='+development_mod,
                dataType: "html"
            }).success(function( msg ) {
                Materialize.toast(msg,5000,'green');
            }).fail(function(){
                 $('#development').prop('checked',!development_mod);
                 Materialize.toast('اشکال در تغییر توسعه',5000,'red');
            })
            
        })
    
    
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
    $('select').material_select();
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
                console.log('Rating: ' + e.detail);
            });
        }
        
    
        
    
    
             
    });