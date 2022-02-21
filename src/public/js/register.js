let regMethod = 0; //0:none selected | 1: nid | 2: bcf
let categoryValue = 0;
let subCategoryValue = 0;
let enrollType;
let enrollSubType ;



var showCategory,showSubCategory;


reset = function (){
  //TODO : to make everything looks like the beginning
    regMethod = 0;
    hideCategory(true);
};

resetCategory=function (){
    resetSubCategory('0');
    hideSubCategory(true);
    categoryValue = 0;
    $('#selectCategoryId').prop('selectedIndex',0);
};
resetSubCategory= function (idx) {
    $('#selectSubCategoryId').empty().append('<option value="0">--Select--</option>');
    if(idx === '0')
    {
        subCategoryValue = 0;
        $('#selectSubCategoryId').prop('selectedIndex',0);
    }
    else if(idx !== '0'){
        fetchSubSectors(idx);
    }

};
hideCategory = function (val) {
    if(val === true)
    {
        resetCategory();
        hideSubCategory(val);
        hideNID(true);
        hideBCF(true);
        hideDOB(true);
    }
    $('#categoryId').prop('hidden',val);
};
hideSubCategory = function (val) {
    if(val === true)
    {
        resetSubCategory('0');
        hideNID(true);
        hideBCF(true);
        hideDOB(true);
    }
    $('#subCategoryId').prop('hidden',val);
};

hideNID = function (val){
    $('#nidCol').prop('hidden',val);
};
hideBCF = function (val){
    $('#bcfCol').prop('hidden',val);
};
hideDOB = function (val){
    $('#dobCol').prop('hidden',val);
};

getRegMethod = function (event){
    var value = $('#regMethodId option:selected').val();
    if(value === 'none')reset();
    else if(value ==='NID')
    {
        regMethod = 1;
        //show all element for nid selection
        hideCategory(false);
        hideNID(true);
        hideBCF(true);
        hideDOB(true);
    }
    else if(value ==='BCF')
    {
        regMethod = 2;
        hideCategory(true);
        hideNID(true);
        hideBCF(false);
        hideDOB(false);
    }
};
getCategory = function () {
    categoryValue = $('#selectCategoryId option:selected').val();
    if(categoryValue === '0') {
        resetSubCategory('0');
        hideSubCategory(true);
        hideNID(true);
        hideDOB(true);
        hideBCF(true);
    }
    else{
        resetSubCategory(categoryValue);
        hideSubCategory(false);
    }
};
getSubCategory= function (){
    subCategoryValue = $('#selectSubCategoryId option:selected').val();
    if(subCategoryValue === '0'){
        hideDOB(true);
        hideNID(true);
    }
    else {
        hideDOB(false);
        hideNID(false);
    }
};


verify = function (event){
    //TODO : complete THIS FUNCTION WITH BACKEND
    var nid = $('#nid').val();
    var dob = $('#dob').val();
    var bcf = $('#bcf').val();
    if(nid==='')nid= 'null';
    if(bcf==='')bcf= 'null';
    data = {regMethod:regMethod, nid:nid, bcf:bcf,dob:dob, sector_id : categoryValue, sub_sector_id : subCategoryValue }
    $.ajax({
        type:'post',
        url : '/v1/registration/s/1',
        data : data,
        success:function (value){
            //console.log('received data : ' + value);
            if(value.success === true)gotoSecondStep(value.name);
            else {
                alert(value.msg);
            }
        }
    });
};

gotoSecondStep = function (data)
{
    $('#secondStep').prop('hidden',false);
    $('#firstStep').prop('hidden',true);
    $('#reg-name').val(data.FIRST_NAME +' '+data.LAST_NAME);
}

fetchSubSectors =  function(id)
{
    let subSectors;
  $.ajax({
      type:'get',
      url:'/v1/category/'+id,
      dataType : 'json',
      success : function (values){
          subSectors = values.subSectors;
          if(values.subSectors[0].id !== null){
              var str = showSubCategory({subCategory:subSectors}).split('\n');
              str.forEach(s=>{
                  $('#selectSubCategoryId').append(s);
              });
          }
          else {
              hideSubCategory(true);
              hideDOB(false);
              hideNID(false);
          }
      },
      error:function (v){
          alert('error');
      }
  });
};

$('#document').ready(function () {
    var subCategoryTemplate = $('#subCategoryT').html();
    showSubCategory = Handlebars.compile(subCategoryTemplate);
    $('#regMethodId').on('change',getRegMethod);
    $('#selectCategoryId').on('change',getCategory);
    $('#selectSubCategoryId').on('change',getSubCategory);
    $('#step1btn').on('click',verify);
});