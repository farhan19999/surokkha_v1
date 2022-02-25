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
    let data = $('#entryFormId').serializeArray();
    let url = '/white/entry/';
    if($('#regType option:selected').val() === 'NID')url += 'process_nid';
    else url += 'process_bcf';

    $.ajax({
       url : url,
       data : data,
       type : 'post',
       success : function (ret){
          if(ret.success === true){
              alert('Entry Successful');
              window.location.href = '/white/entry';
          }
          else {
              alert('Entry Unsuccessful');
          }
          window.location.href = '/white/entry';
       }
    });
};

fileUploadHandler = function (event){
    event.preventDefault();
    $.ajax({
        // Your server script to process the upload
        url: `/white/entry/process_csv/${$('#selectCsv option:selected').val()}`,
        type: 'POST',

        // Form data
        data: new FormData($('#csvFileUploadId')[0]),

        // Tell jQuery not to process data or worry about content-type
        // You *must* include these options!
        cache: false,
        contentType: false,
        processData: false,

        // Custom XMLHttpRequest
        xhr: function () {
            var myXhr = $.ajaxSettings.xhr();
            if (myXhr.upload) {
                // For handling the progress of the upload
                myXhr.upload.addEventListener('progress', function (e) {
                    if (e.lengthComputable) {
                        $('progress').attr({
                            value: e.loaded,
                            max: e.total,
                        });
                    }
                }, false);
            }
            return myXhr;
        },
        success : function (ret){
            if(ret.success===true){
                alert('File uploaded successfully');
            }
            else {
                alert('couldn\'t upload file due to format error');
            }
            window.location.href = '/white/entry';
        },
        error:function (ret)
        {
            alert('Error sending request')
        }
    });

};

activeCsv = function (event){
    if($('#selectCsv option:selected' ).val() !== 'none'){
        $('#csvSubmitBtn').prop('disabled', false);
    }
    else $('#csvSubmitBtn').prop('disabled', true);
}

$('document').ready(function (){

    var subCategoryTemplate = $('#subCategoryT').html();
    showSubCategory = Handlebars.compile(subCategoryTemplate);

    $('#regType').on('change',regAction);
    $('#selectCategoryId').on('change',categoryAction);
    $('#submitBtn').on('click',formSubmitAction);

    $('#selectCsv').on('change',activeCsv);
    $('#csvSubmitBtn').on('click',fileUploadHandler);

});