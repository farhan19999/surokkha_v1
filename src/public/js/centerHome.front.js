vaccineAdministrationDataEntry = function (event){
    event.preventDefault();
    let data = $('#entryFormId').serialize();
    $.ajax({
       type:'post',
       data : data,
       url:'/center/home/entry',
       success : function (ret){
           if(ret.success)
           {
               alert('Successfully Entered to the database');
               window.location.href = '/center/home/entry';
           }
           if(ret.status ==='redirect')window.location.href = ret.url;
       },
       error : function (ret){
           alert(ret);
       }
    });
};

fileUploadHandler = function (event){
  event.preventDefault();
    $.ajax({
        // Your server script to process the upload
        url: '/center/fileUpload',
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
          window.location.href = '/center/home/entry';
        },
        error:function (ret)
        {
            alert('Error sending request')
        }
    });

};

$('document').ready(function (){
   $('#entryFormId').on('submit',vaccineAdministrationDataEntry);
   $('#csvFileUploadId').on('submit',fileUploadHandler);
});