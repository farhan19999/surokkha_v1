let table;
let selectedRowID=-1;
let btn;
let header;
let formID,tableName;



saveDataFunc = function (event){
  //have to send req to server
    let updatedData = {};
    updatedData = $('#'+formID).serialize();
    $.ajax({
        url : '/tables/'+tableName,
        type : 'put',
        data : updatedData,
        success : function (msg){
            alert('updated successfully.');
            //now update table row
            var array = $('#'+formID).serializeArray();
            console.log('Serialized msg :' +updatedData);
            console.log('serialized Array : '+array[0]);
            var prev = table.row(selectedRowID).data();
            for(var i = 0 ;i<prev.length ; i++)prev[i] = array[i].value;
            //console.log(prev);
            table.row(selectedRowID).data(prev).invalidate();
        }
    });
};
insertDataFunc = function (){
    let insertedData = {};
    insertedData = $('#'+formID).serialize();
    $.ajax({
        url : '/tables/'+tableName,
        type : 'post',
        data : insertedData,
        success : function (msg){
            alert('inserted successfully.');
            //get new row from msg
            let insertedDataArray = $('#'+formID).serializeArray();
            let tableArray = table.row(0).data();
            tableArray[0]=msg.r; //TODO: INITIALIZE WITH GETTING NEW ID
            for(var i = 1;i<tableArray.length ; i++ )tableArray[i] = insertedDataArray[i].value;
            //insert it into table
            table.row.add(tableArray).draw(false);
            $('#modalId').modal('toggle');

        }
    });

};

locationFormPopulate = function (data)
{
    var frm = $('#'+formID);
  $.each(data,function (key,value){
      $('[name='+key.toLowerCase()+']',frm).val(value);
  });
  console.log('Form populated ....');
};

/**
 * @param event
 */
editButtonFunc = function(event){
    //afterRowSelectionCompleted(btn);
    //populate modal
    let data = createObject(header,table.row(selectedRowID).data());
    locationFormPopulate(data);
    $('#modal-save-id').prop('hidden',false);
    $('#modal-insert-id').prop('hidden',true);

    //console.log('populated');
    //take data and send to an api request
    //update table
    //reset three buttons

} ;

deleteButtonFunc = function (event) {
    //console.log('delete req is sent for '+ event.data.data.LOCATION_ID);
    //afterRowSelectionCompleted(btn);
    //send to an api request
    //update table
    //row.deselect();
    console.log(selectedRowID + ' is deleted.');
    let data = createObject(header,table.row(selectedRowID).data());
    console.log(data);
    $.ajax({
        url : '/tables/'+tableName,
        type : 'delete',
        data : data,
        success : function (msg){
            alert('deleted successfully.');

            //now update table
            var temp =selectedRowID;
            table.row(selectedRowID).deselect();
            table.row(temp).remove().draw();
        }
    });
};

insertButtonFunc = function (event)
{
    //open modal
    $('#modal-save-id').prop('hidden',true);
    $('#modal-insert-id').prop('hidden',false);
    //take data and send to an api request
    //update table
};

getHeader = function() {
    var header = [];
    var nRows = $('#table_id thead tr')[0];
    $.each(nRows.cells, (i,v)=>{header.push(v.innerText)});
    return header;
};
createObject = function (keys,values) {
  var obj = {};
  if(keys.length === values.length)
  {
      for(var i = 0 ; i<keys.length ; i++)
      {
          obj[""+keys[i].toLowerCase()]=values[i];
      }
  }
  return obj;
};
afterRowSelection = function (btn){
    //true for every table
    btn.ins.prop('disabled',true);
    btn.edit.prop('disabled',false);
    btn.del.prop('disabled',false);
};
afterRowSelectionCompleted = function (btn){
    //true for every table
    btn['ins'].prop('disabled',false);
    btn['edit'].prop('disabled',true);
    btn['del'].prop('disabled',true);
};

$(document).ready( function () {
    table = $('#table_id').DataTable({select: true});
    btn = {ins: $('#insertButton'), edit: $('#editButton'), del: $('#deleteButton')};
    header = getHeader();
    formID = $('#modalId form').attr('id');
    tableName = $('#table_id caption').text();

    $('#modal-save-id').on('click',saveDataFunc);
    $('#modal-insert-id').on('click',insertDataFunc);
    $('#modalId').on('hide.bs.modal',()=>{
        if(selectedRowID!==-1)table.row(selectedRowID).deselect();
    });

    btn.ins.on('click',insertButtonFunc);
    btn.edit.on('click',editButtonFunc);
    btn.del.on('click',deleteButtonFunc);

    table.on('select',function (e,dt,type,indexes){
        if(type ==='row'){
            selectedRowID = indexes[0];
            //activate edit and delete
            afterRowSelection(btn);
        }
    });
    table.on('deselect',function (e,dt,type,indexes) {
        if (type === 'row') {
            selectedRowID = -1;
            afterRowSelectionCompleted(btn);
        }
    });
});

