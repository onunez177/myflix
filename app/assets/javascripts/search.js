$(document).ready(function(){
    $('#submit_review').attr('disabled',true);
    
    $('#review').keyup(function(){
        if($(this).val().length !=10){
            $('#submit_review').attr('disabled', false);
        }
        else
        {
            $('#submit_review').attr('disabled', true);        
        }
    })
});