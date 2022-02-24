var oracledb = require('oracledb');
var config = require('../config/database.config');


/**
 * THIS SERIAL SHOULD BE MAINTAINED FOR AUTOMATION
 * vaccine_id : number
 * vaccine_name : text
 * manufacturer : text
 * stock :  number
 * shelf_life : number
 *
 */
const formData =
    [
        {label:'Vaccine ID',name:'vaccine_id',type:'number',prop:'readonly'},
        {label:'Vaccine Name',name:'vaccine_name',type:'text',prop:''},
        {label:'Manufacturer',name:'manufacturer',type:'text',prop:''},
        {label:'Stock',name:'stock',type:'number',prop:''},
        {label:'Shelf Life',name:'shelf_life',type:'number',prop:''}
    ];

findVaccineByID = async function (id){
    let row = {};
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT * FROM VACCINE WHERE VACCINE_ID = :0`,
            [id],
            {maxRows:1,outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
        //console.log(result.rows[0]);

        row = result.rows[0];
    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
    return row;
};
loadAllVaccine = async function() {
    let table = [];
    let metaData = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT * FROM VACCINE`,
            [],
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        metaData = result.metaData;
        let row;
        while((row = await result.resultSet.getRow()))
        {
            table.push(row);
        }
        //console.log(table);
        await result.resultSet.close();
    }catch (e)
    {
        console.log(e);
    }
    finally {
        if(connection) {
            try{
                await connection.close();
            }
            catch (e){
                console.log(e);
            }
        }
    }
    return {tableName:'vaccine',tableHead:metaData,tableData:table};
};
updateVaccine = async function (row){
    let connection;
    let r;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `UPDATE VACCINE SET 
                                vaccine_name = :vaccine_name,
                                manufacturer = :manufacturer,
                                shelf_life = :shelf_life,
                                stock =  :stock
                                WHERE VACCINE_ID = :vaccine_id`,
            row,
            {
                autoCommit:true
            }
        );
        if(result.rowsAffected)r=result.rowsAffected;

    }catch (e)
    {
        console.log(e);
    }
    finally {
        if(connection) {
            try{
                await connection.close();
            }
            catch (e){
                console.log(e);
            }
        }
    }
    return r;
};
deleteVaccine = async function(row){
    //console.log(row);
    let connection;
    var r;
    let data = {vaccine_id : row.vaccine_id};
    if(!data.vaccine_id){
        return r;
    }
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `DELETE 
             FROM VACCINE
             WHERE VACCINE_ID = :vaccine_id`,
            data,
            {
                autoCommit:true
            }
        );
        if(result.rowsAffected){
            r = result.rowsAffected;
        }
    }catch (e)
    {
        console.log(e);
    }
    finally {
        if(connection) {
            try{
                await connection.close();
            }
            catch (e){
                console.log(e);
            }
        }
    }
    return r;
};
insertVaccine = async function (row) {
    let insertedRowID; //for updating table in ui
    let connection;
    let data ={
        vaccine_name:row.vaccine_name,
        manufacturer:row.manufacturer,
        shelf_life:row.shelf_life,
        stock:row.stock
    };
    //console.log(data);

    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `INSERT INTO VACCINE 
             (VACCINE_NAME, MANUFACTURER, SHELF_LIFE, STOCK)   
             values 
             (:vaccine_name, :manufacturer, :shelf_life, :stock)`,
            data,
            {
                autoCommit : true
            }
        );
        //console.log('Row inserted : '+result.rowsAffected);
        if(result.rowsAffected){
            result = await connection.execute
            (   `SELECT VACCINE_ID FROM VACCINE WHERE VACCINE_NAME = :vaccine_name`,
                [data.vaccine_name],
                {
                    maxRows :1,
                    outFormat: oracledb.OUT_FORMAT_OBJECT
                }
            );
            //console.log(result);
            if(result.rows[0])insertedRowID = result.rows[0].VACCINE_ID;
        }
    }catch (e)
    {
        console.log(e);
    }
    finally {
        if(connection) {
            try{
                await connection.close();
            }
            catch (e){
                console.log(e);
            }
        }
    }
    return insertedRowID;
};
findVaccineID = async function(vaccine_name, manufacturer) {
    let id;
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT VACCINE_ID FROM VACCINE WHERE VACCINE_NAME = :VACCINE_NAME AND MANUFACTURER = :MANUFACTURER`,
            {VACCINE_NAME : vaccine_name, MANUFACTURER : manufacturer},
            {maxRows:1,outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
        //console.log(result.rows[0]);

        id = result.rows[0];
    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
    return id;
}


//test function
run = function (){
    /*findVaccineID('Comirnaty','Pfizer')
        .then(r=>{console.log(r);})
        .catch(e=>{console.log(e);});

     */
    deleteVaccine({vaccine_id: 21}).then(r=>console.log(r));
};
//run();

module.exports = {
    findVaccineByID,
    updateVaccine,
    insertVaccine,
    deleteVaccine,
    loadAllVaccine,
    findVaccineID,
    formData
};