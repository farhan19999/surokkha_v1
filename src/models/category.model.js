var oracledb = require('oracledb');
var config = require('../config/database.config');
var combine = require('../utils/combine').comb;

loadAllCategory = async function (){
    let connection;
    let sector=[];
    let subsector={};
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(`SELECT SECTOR_ID, SECTOR_NAME FROM CATEGORY WHERE CATEGORY_ID != 99 group BY SECTOR_ID, SECTOR_NAME`,[],{resultSet:true, outFormat: oracledb.OUT_FORMAT_OBJECT});
        let row;
        while((row = await  result.resultSet.getRow())){
            sector.push({id:row.SECTOR_ID,title: row.SECTOR_NAME});
            let val = await findSubSector(row.SECTOR_ID);
            if(val.subSectors[0].id === null)continue;
            subsector[val.key] = val.subSectors;
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
    //console.log(subsector);
    return {sector:sector,subSector:subsector};
};

findSubSector = async function (id) {
    let connection;
    let subsector=[];
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(`SELECT SUB_SECTOR_ID, SUB_SECTOR_NAME FROM CATEGORY WHERE  SECTOR_ID = :V`,[id],{resultSet:true, outFormat: oracledb.OUT_FORMAT_OBJECT});
        let row;
        while((row = await  result.resultSet.getRow())){
            subsector.push({id:row.SUB_SECTOR_ID,title: row.SUB_SECTOR_NAME});
        }
        //console.log(subsector);
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
    let K = ''+id;
    return {key :K, subSectors:subsector};
};

insertAllCategory = async function (data){
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.executeMany(
            `INSERT INTO CATEGORY (SECTOR_ID, SECTOR_NAME, SUB_SECTOR_ID, SUB_SECTOR_NAME)
             VALUES (:SECTOR_ID, :SECTOR_NAME, :SUB_SECTOR_ID, :SUB_SECTOR_NAME)`,
            data,{
                autoCommit : true,
                bindDefs : {
                    SECTOR_ID: {type : oracledb.NUMBER},
                    SECTOR_NAME: {type : oracledb.STRING,  maxSize : 200},
                    SUB_SECTOR_ID: {type : oracledb.NUMBER},
                    SUB_SECTOR_NAME:{type : oracledb.STRING, maxSize : 200}
                }
            });
        console.log(result.affectedRows());
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
};

findCategoryIdFromName = async function(data) {
    let connection;
    let id;
    //console.log(data);
    var sql = `SELECT CATEGORY_ID FROM CATEGORY WHERE SECTOR_NAME like '${data.SECTOR_NAME}'`;
    if(data.SUB_SECTOR_NAME !== ''){
        sql +=` AND SUB_SECTOR_NAME like '${data.SUB_SECTOR_NAME}'`;
    }
    //console.log(sql);
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(
          sql,
          [],
            {
                maxRows : 1,
                outFormat: oracledb.OUT_FORMAT_OBJECT
            }
        );
        id = result.rows[0];
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
findCategoryId = async function(data){
    let connection;
    let id;
    var sql = `SELECT CATEGORY_ID FROM CATEGORY WHERE SECTOR_ID = ${data.sector_id}`;
    if(data.sub_sector_id)
    {
        if(data.sub_sector_id !== '0' && data.sub_sector_id !== 0)sql+=` AND SUB_SECTOR_ID = ${data.sub_sector_id}`;
    }
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(
            sql,
            [],
            {
                maxRows : 1
            }
        );
        if(result.rows[0]){
            id = result.rows[0][0];
        }
    }catch (e) {
        console.log(`Error in finding category id... ${JSON.stringify(data)}`);
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
run = function (){
    findCategoryId({sector_id:1})
        .then(v=>{
            console.log(v);
        })
        .catch(e=>{console.log(e);});
};
//run();

module.exports = {
    loadAllCategory,
    findSubSector,
    findCategoryId,
    findCategoryIdFromName
}