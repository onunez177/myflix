$(document).ready(function(){
    $('#search_button').attr('disabled',true);
    
    $('#search').keyup(function(){
        if($(this).val().length !=0){
            $('#search_button').attr('disabled', false);
        }
        else
        {
            $('#search_button').attr('disabled', true);        
        }
    })
});