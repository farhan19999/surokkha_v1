var oracledb = require('oracledb');
var config = require('../config/database.config');
/***
 * location :
 *      location_id : int
 *      union_or_ward : int
 *      city_or_municipality : string
 *      upazilla_or_thana : string
 *      district : string
 *      division : string
 */
const formData =
    [
        {label:'Location ID',name:'location_id',type:'number',prop : 'readonly'},
        {label:'Union/Ward',name:'union_or_ward',type:'number',prop:'required'},
        {label:'City Corporation/Municipality',name:'city_or_municipality',type:'text',prop:'required'},
        {label:'Upazilla/Thana',name:'upazilla_or_thana',type:'text',prop:'required'},
        {label:'District',name:'district',type:'text',prop:'required'},
        {label:'Division',name:'division',type:'text',prop:'required'}
    ];



findLocationByID = async function (id){
    let row = {};
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT * FROM LOCATION WHERE LOCATION_ID = :V`,
            [id],
            {maxRows:1,outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
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
updateLocation = async function (row){
    //let old = await findLocationByID(row.location_id);
    //can't compare whole row and update only those row because it's pain
    let connection;
    let affectedRow;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `UPDATE LOCATION SET 
                                 union_or_ward = :union_or_ward,
                                 city_or_municipality = :city_or_municipality,
                                 upazilla_or_thana = :upazilla_or_thana,
                                 district = :district,
                                 division = :division
                                 WHERE LOCATION_ID = :location_id`,
            row,
            {
                autoCommit:true
            }
        );
        if(result.rowsAffected)affectedRow = result.rowsAffected;
        //console.log('Row updated : '+result.rowsAffected);
        //if(result.rowsAffected)insertedRowID = result.lastRowid;
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
    return affectedRow;
};
deleteLocation = async function(row){
    let connection;
    let r;
    let data = {location_id : row.location_id};
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `DELETE FROM LOCATION WHERE LOCATION_ID = :location_id`,
            data,
            {
                //autoCommit:true
            }
        );
        if(result.rowsAffected)r=result.rowsAffected;
        //console.log('Row deleted : '+result.rowsAffected);
        //if(result.rowsAffected)insertedRowID = result.lastRowid;
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
insertLocation = async function (row) {
    let insertedRowID; //for updating table in ui
    let connection;
    let data ={union_or_ward:row.union_or_ward ,city_or_municipality:row.city_or_municipality,upazilla_or_thana:row.upazilla_or_thana,district:row.district,division:row.division};
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `INSERT INTO LOCATION 
             (union_or_ward, city_or_municipality, upazilla_or_thana, district, division)   
             values 
             (:union_or_ward, :city_or_municipality, :upazilla_or_thana, :district, :division)`,
             data,
             {
                 autoCommit : true
             }
        );
        if(result.rowsAffected){
            result = await connection.execute(
                `SELECT LOCATION_ID FROM LOCATION WHERE DIVISION = :division and DISTRICT = :district and UPAZILLA_OR_THANA = :upazilla_or_thana and CITY_OR_MUNICIPALITY = :city_or_municipality and UNION_OR_WARD = :union_or_ward`,
                data,
                {maxRows : 1 }
                );

            insertedRowID = result.rows[0][0];
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
loadAllLocation = async function() {
    let table = [];
    let metaData = [];
    let connection;
    try{
      connection = await oracledb.getConnection(config);
      let result = await connection.execute
      (   `SELECT * FROM LOCATION`,
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
    return {tableName:'location',tableHead:metaData,tableData:table};
};
getAllDivision = async function() {
    let divisions = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT DIVISION FROM LOCATION group BY DIVISION`,
            [],
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            divisions.push(row);
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
    return divisions;
}
getDistrict = async function(division) {
    let districts = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT DISTRICT FROM LOCATION WHERE DIVISION = :v GROUP BY DISTRICT `,
            [division],
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            districts.push(row);
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
    return districts;
}
getUT = async function(division, district) {
    let ut = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT UPAZILLA_OR_THANA FROM LOCATION WHERE DIVISION = :div and DISTRICT = :dis group BY UPAZILLA_OR_THANA `,
            {div:division,dis:district},
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            ut.push(row);
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
    return ut;
}
getCityMun = async function(division, district, ut) {
    let cityMun = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT CITY_OR_MUNICIPALITY FROM LOCATION WHERE DIVISION = :div and DISTRICT = :dis and UPAZILLA_OR_THANA = :ut group BY CITY_OR_MUNICIPALITY`,
            {div:division, dis: district, ut : ut},
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            cityMun.push(row);
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
    return cityMun;
}
getWardUn = async function(division, district, ut, cityMun) {
    let wardUn = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT UNION_OR_WARD FROM LOCATION WHERE DIVISION = :div and DISTRICT = :dis and UPAZILLA_OR_THANA = :ut and CITY_OR_MUNICIPALITY = :c group BY UNION_OR_WARD`,
            {div:division, dis: district, ut : ut, c: cityMun},
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            wardUn.push(row);
        }
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
    return wardUn;
}
getLocationId = async function(division, district, ut, cityMun, unw) {
    let id;
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT LOCATION_ID FROM LOCATION WHERE DIVISION = :div and DISTRICT = :dis and UPAZILLA_OR_THANA = :ut and CITY_OR_MUNICIPALITY = :c and UNION_OR_WARD = :unw`,
            {div:division, dis: district, ut : ut, c: cityMun, unw : unw},
            {maxRows : 1 }
        );
        id = result.rows[0][0];
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
    return id;
}
//test function
run = function (){
    getLocationId('Dhaka','Dhaka','Ramna','Dhaka South City Corporation','20').then(value => {console.log(value)}).catch(e=>console.log(e));
    //getAllDivision().then(v=>console.log(v)).catch(e=>console.log(e));
    //updateLocationRow({location_id : 123,district:'DHAKA'}).then(r=>{});
    //insertLocation({union_or_ward:2 ,city_or_municipality:'dncc',upazilla_or_thana:'mirpur',district:'dhaka',division:'DHAKA'}).then(r=>{});
};
 //run();

 module.exports =
     {
         findLocationByID,
         updateLocation,
         insertLocation,
         deleteLocation,
         loadAllLocation,
         formData,
         getAllDivision,
         getDistrict,
         getUT,
         getCityMun,
         getWardUn,
         getLocationId
     };