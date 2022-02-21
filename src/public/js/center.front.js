verifyLogin = function (event){
    event.preventDefault();
    var data = $('#centerForm').serialize();
    //console.log(data);
    $.ajax({
        type:'post',
        url:'/center/login',
        data : data,
        dataFormat : 'json',
        success : function (ret){
            //console.log(ret);
            if(ret.success)window.location.href = '/center/home';
        },
        error : function (ret){
            alert(ret);
        }
    });
};

$('document').ready(function (){
    $('#centerForm').on('submit',verifyLogin);
});