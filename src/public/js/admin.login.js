
loginHandler = function (event){
    $.ajax({
        url:'/login',
        data:$('#adminValidationForm').serialize(),
        type:'post',
        success : function (ret){
            if(ret.success === true){
                window.location.href = '/';
            }
            else{
                alert(ret.msg);
                window.location.href = '/login';
            }
        },
        error :function (ret){
            alert('Couldn\'t connect to server' );
        }
    });
};

$('document').ready(function (){
    $('#adminFormBtn').on('click',loginHandler);
});