//= require jquery

//= require jquery.turbolinks
//= require materialize
//= require turbolinks
//= require admin/main
//= require_self

$(document).ready(function(){
    setInterval(function(){
            Materialize.updateTextFields();  
    },2000)
})

