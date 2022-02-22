var showSubCategory;

reset =function (){
    $('#nidSection').prop('hidden',true);
};

regAction = function (){
    let s = $('#regType option:selected').val();
    reset();
    if(s ==='NID'){
        $('#nidSection').prop('hidden',false);
        $('#bcfSection').prop('hidden',true);
    }
    else if(s === 'BCF'){
        $('#bcfSection').prop('hidden',false);
        $('#nidSection').prop('hidden',true);
    }

};
resetCategory =function (){
} ;

categoryAction = function (){
    console.log('category Action is called ....');
    let id = $('#selectCategoryId option:selected').val();
    resetSubCategory();
    if(id!=='0'){
        $.ajax({
            url:`/v1/category/${id}`,
            type:'get',
            success : function (ret){
                if(ret.subSectors[0].id !== null){
                    let array = showSubCategory({subCategory:ret.subSectors}).split('\n');
                    $('#subCategoryId').prop('hidden',false);
                    $('#nidCol').prop('hidden',false);
                    array.forEach(s=>{
                        $('#selectSubCategoryId').append(s);
                    });
                }
            }
        });
    }
    else {
        $('#subCategoryId').prop('hidden',true);
        $('#nidCol').prop('hidden',true);
    }
};

subCategoryAction = function (event){
    if($('#selectSubCategoryId option:selected').val() === '0'){
        $('#nidCol').prop('hidden',true);
    }
    else $('#nidCol').prop('hidden',true);
};

resetSubCategory = function(){
    $('#subCategoryId').prop('hidden',true);
    $('#nidCol').prop('hidden',false);
    $('#selectSubCategoryId').empty().append('<option selected value="0">--Select--</option>');
};

formSubmitAction = function (event){
    event.preventDefault();
    let data = $('entryFormId').serialize();
    let url = '/white/entry/';
    if(data.regType === 'NID')url += 'process_nid';
    else url += 'process_bcf';
    $.ajax({
       url : url,
       data : data,
       type : 'post',
       success : function (ret){
          if(ret.success === true){
              alert('Entry Successful');
          }
          else {
              alert('Entry Unsuccessful');
          }
          window.location.href = '/white/entry';
       }
    });
};

$('document').ready(function (){
    console.log('Document is ready.......');
    var subCategoryTemplate = $('#subCategoryT').html();
    showSubCategory = Handlebars.compile(subCategoryTemplate);

    $('#regType').on('change',regAction);
    $('#selectCategoryId').on('change',categoryAction);
    $('#submitBtn').on('click',formSubmitAction);
});