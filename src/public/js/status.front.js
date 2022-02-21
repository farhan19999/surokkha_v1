var showStatus;
statusVerifyAction = function (event){
    let data = {dob :$('#dob').val(), pwd : $('#pwd').val()};
    let type = $('#selectType option:selected').val();
    if(type==='NID')
    {
        data.uid = $('#nid').val();
    }
    else data.uid =$('#bcf').val();
    $.ajax({
        url:`/v1/vaccine-status/getStatus/${type}`,
        type:'post',
        data:data,
        success : function (ret){
            if(ret.success === true){
                if(ret.data){
                    var sarray =showStatus({history:ret.data}).split('\n');
                    sarray.forEach(s=>{
                       $('#historyTable tbody').append(s);
                    });
                    $('#statusSection').prop('hidden',false);
                }
                else {
                    alert('You haven\'t yet vaccinated');
                }
            }
            else {
                alert(ret.msg);
            }
        }
    });
};


$('document').ready(function (){
    $('#statusBtn').on('click',statusVerifyAction);
    var historyTemplate = $('#historyTemp').html();
    showStatus = Handlebars.compile(historyTemplate);
});