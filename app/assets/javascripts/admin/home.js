//= require jquery
//= require jquery_ujs
//= require materialize
//= require admin/main
//= require_self

$(document).ready(function(){
    setInterval(function(){
            Materialize.updateTextFields();  
    },2000)
})

