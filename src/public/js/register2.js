var showCenter,showLocation;
loadCenter = function (district,ut){
    $.ajax({
        type:'get',
        url:'/v1/center/'+district+'/'+ut+'/'+1,
        success:function (value)
        {
            console.log('centers : ' + value);
            if(value)setCenters(value);
        }
    });
};

setCenters = function (data)
{
    $('#selectCenterId').empty().append('<option selected value="">--Select--</option>');
    var str = showCenter({center:data}).split('\n');
    str.forEach(s=>{
        $('#selectCenterId').append(s);
    });
}
getStep1Data = function (){
    return {nid : $('#nid').val(), bcf : $('#bcf').val(), dob : $('#dob').val(),sector_id : $('#selectCategoryId option:selected').val(), sub_sector_id:  $('#selectSubCategoryId option:selected').val()}
}
register = function (event){
    //get all data
    var regType = $('#regMethodId option:selected').val();
    var fn = $('#reg-name').val().split(' ')[0];
    var ln = $('#reg-name').val().split(' ')[1];
    var pwd = $('#pwd').val();
    var {nid, bcf ,dob, sector_id, sub_sector_id} = getStep1Data(); //get them from hidden element
    var ph_num = $('#mobile-number').val();
    var email = $('#mail-id').val();
    var hbp = $('input[name=hbp]:checked').val();
    var kd = $('input[name=kd]:checked').val();
    var resp = $('input[name=resp]:checked').val();
    var prev_cov = $('input[name=prev_cov]:checked').val();
    var cancer = $('input[name=cancer]:checked').val();
    var dbts = $('input[name=dbts]:checked').val();
    var unw = $('#selectUnwId option:selected').val();
    var ut = $('#selectUtId option:selected').val();
    var cityMun = $('#selectCityMunId option:selected').val();
    var dist = $('#selectDistId option:selected').val();
    var div = $('#selectDivId option:selected').val();
    var prefCenterId = $('#selectCenterId option:selected').val();
    var formData = {regType : regType, fn :fn, ln : ln,pwd:pwd, nid: nid, bcf : bcf, dob: dob, sector_id : sector_id, sub_sector_id : sub_sector_id, ph_num:ph_num,email:email,hbp : hbp, kd:kd, resp : resp, prev_cov: prev_cov, cancer:cancer, dbts:dbts,unw:unw, cityMun : cityMun, ut:ut,dist:dist, div:div, prefCenter:prefCenterId};
    $.ajax({
        type:'post',
        url:'/v1/registration/s/2/',
        data: formData,
        success : function (value){
            alert('successfully registered');
            //window.location.href = '/v1/home'
        }
    });
};
resetLocation = function (type, data){
    var str = showLocation({location:data}).split('\n');
    if(type==='dis')
    {
        $('#selectDistId').empty().append('<option selected value="">--Select--</option>')
        str.forEach(s=>{
           $('#selectDistId').append(s);
        });
    }
    else if(type==='uT')
    {
        $('#selectUtId').empty().append('<option selected value="">--Select--</option>')
        str.forEach(s=>{
            $('#selectUtId').append(s);
        });
    }
    else if(type==='cityMun')
    {
        $('#selectCityMunId').empty().append('<option selected value="">--Select--</option>')
        str.forEach(s=>{
            $('#selectCityMunId').append(s);
        });
    }
    else if(type==='unw')
    {
        $('#selectUnwId').empty().append('<option selected value="">--Select--</option>')
        str.forEach(s=>{
            $('#selectUnwId').append(s);
        });
    }
}
getAllLocation = function (){
    let location = {};
    if($('#selectDivId option:selected').val() !== '')location.div = $('#selectDivId option:selected').val();
    if($('#selectDistId option:selected').val() !== '')location.dis = $('#selectDistId option:selected').val();
    if($('#selectUnwId option:selected').val() !== '')location.unw = $('#selectUnwId option:selected').val();
    if($('#selectUtId option:selected').val() !== '')location.ut = $('#selectUtId option:selected').val();
    if($('#selectCityMunId option:selected').val() !== '')location.cityMun = $('#selectCityMunId option:selected').val();
    return location;

};

setData = function (type)
{
    let location = getAllLocation();
    let data = {};
    if(type === 'dis'){
        data.div = location.div;
    }
    else if(type === 'uT'){
        data.div = location.div;
        data.dis = location.dis;
    }
    else if(type === 'cityMun'){
        data.div = location.div;
        data.dis = location.dis;
        data.ut = location.ut;
    }
    else if(type === 'unw'){
        data.div = location.div;
        data.dis = location.dis;
        data.ut = location.ut;
        data.cityMun = location.cityMun;
    }
    return data;
}


fetchLocation = function (type){
    let url = '/v1/location';
    let data = setData(type);
    //console.log(data);
    $.ajax({
        url : url,
        data : data,
        type : 'post',
        success : function (value){
            //console.log('sent for '+type+' '+data)
             resetLocation(type,value);
             if(value.empty)alert('No location');
        },
        error : function (value){
            alert('error in fetching location');
        }
    });
};
setDivision = function (event)
{
    clearDis();
    if($('#selectDivId option:selected').val() !== '')fetchLocation('dis');
}
setDistrict = function (event)
{
    clearUT();
    if($('#selectDistId option:selected').val() !== '')fetchLocation('uT');
}
setUT = function (event)
{
    clearCityMun();
    $('#selectCenterId').empty().append('<option selected value="">--Select--</option>');
    if($('#selectUtId option:selected').val() !== ''){
        fetchLocation('cityMun');
        loadCenter($('#selectDistId option:selected').val(),$('#selectUtId option:selected').val());
    }

}
setCityMun = function (event)
{
    clearUnw();
    if($('#selectCityMunId option:selected').val() !== '')fetchLocation('unw');
}



clearDis = function ()
{
    $('#selectDistId option').empty().append('<option selected value="">--Select--</option>');
    clearUT();
}
clearUT = function ()
{
    $('#selectUtId option').empty().append('<option selected value="">--Select--</option>');
    clearCityMun();
}

clearCityMun = function (){
    $('#selectCityMunId option').empty().append('<option selected value="">--Select--</option>');
    clearUnw();
}

clearUnw = function(){
  $('#selectUnwId option').empty().append('<option selected value="">--Select--</option>');
};
$('document').ready(function (){
    var centerTemp = $('#centerT').html();
    showCenter = Handlebars.compile(centerTemp);
    var locationTemp = $('#locTemplate').html();
    showLocation = Handlebars.compile(locationTemp);
    $('#successBtn').on('click',register);
    $('#selectDivId').on('change',setDivision);
    $('#selectDistId').on('change',setDistrict);
    $('#selectUtId').on('change',setUT);
    $('#selectCityMunId').on('change',setCityMun);
});