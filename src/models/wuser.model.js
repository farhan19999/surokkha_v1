const config =require('../config/database.config');
var oracledb = require('oracledb');

verifyLogin = async function (username, password){
    let wInfo;
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `SELECT * FROM WUSER WHERE USER_NAME = :n AND PASSWORD = :p`,
            { n: username, p :password},
            {maxRows : 1, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        wInfo = result.rows[0];
    }catch (e) {
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
    return wInfo;
};

insertNidUser = async function(i_id,nid,dob,fname,lname,category_id){
    let connection;
    let insRows;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `INSERT INTO AFFILIATION (INSTITUTION_ID, FIRST_NAME, LAST_NAME, NID_NO, DATE_OF_BIRTH, CATEGORY_ID)
             values (:INSTITUTION_ID, :FIRST_NAME, :LAST_NAME, :NID_NO, to_date(:DATE_OF_BIRTH,'yyyy-mm-dd'), :CATEGORY_ID)`,
            {INSTITUTION_ID:i_id, FIRST_NAME:fname, LAST_NAME:lname, NID_NO:nid, DATE_OF_BIRTH:dob, CATEGORY_ID:category_id},
            {autoCommit:true}
        );
        insRows = result.rowsAffected;
    }catch (e) {
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
    return insRows;
};
insertBcfUser = async function(i_id,bcf,dob,fname,lname){
    let connection;
    let insRows;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `INSERT INTO U18_INFO (INSTITUTION_ID, FIRST_NAME, LAST_NAME, BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, CATEGORY_ID)
             values (:INSTITUTION_ID, :FIRST_NAME, :LAST_NAME, :BIRTH_CERTIFICATE_NO, to_date(:DATE_OF_BIRTH,'yyyy-mm-dd'), :CATEGORY_ID)`,
            {INSTITUTION_ID:i_id, FIRST_NAME:fname, LAST_NAME:lname, BIRTH_CERTIFICATE_NO:bcf, DATE_OF_BIRTH:dob, CATEGORY_ID:99 },
            {autoCommit:true}
        );
        insRows = result.rowsAffected;
    }catch (e) {
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
    return insRows;
};

insertManyPerson = async function(type,objArray){
    //console.log(objArray);
    let connection;
    let insRows;
    let bindDefs = {
        INSTITUTION_ID:{type:oracledb.NUMBER} ,
        FIRST_NAME:{type:oracledb.STRING, maxSize : 50},
        LAST_NAME:{type:oracledb.STRING, maxSize : 50},
        DATE_OF_BIRTH:{type:oracledb.STRING, maxSize : 15},
        CATEGORY_ID:{type:oracledb.NUMBER}
    };
    let sql= `INSERT INTO`;
    if(type === 'NID'){
        sql +=` AFFILIATION (INSTITUTION_ID, FIRST_NAME, LAST_NAME, NID_NO, DATE_OF_BIRTH, CATEGORY_ID) values (:INSTITUTION_ID, :FIRST_NAME, :LAST_NAME, :NID_NO, to_date(:DATE_OF_BIRTH,\'mm/dd/yyyy\'), :CATEGORY_ID)`;
        bindDefs.NID_NO = {type:oracledb.NUMBER};
    }
    else {
        sql +=` U18_INFO (INSTITUTION_ID, FIRST_NAME, LAST_NAME, BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, CATEGORY_ID) values (:INSTITUTION_ID, \':FIRST_NAME\', \':LAST_NAME\', :BIRTH_CERTIFICATE_NO, to_date(:DATE_OF_BIRTH,\'mm/dd/yyyy\'), :CATEGORY_ID)`;
        bindDefs.BIRTH_CERTIFICATE_NO = {type:oracledb.NUMBER};
    }
    console.log(sql);
    console.log(objArray);
    try{
        connection = await oracledb.getConnection(config);
        let result;
        result = await connection.executeMany
        (
            sql,
            objArray,
            {
                //bindDefs : bindDefs,
                autoCommit:true
            }
        );
        insRows = result.rowsAffected;
    }catch (e) {
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
    return insRows;
} ;

getUserInfoById = async function(id){
    let wInfo;
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `SELECT * FROM WUSER WHERE INSTITUTION_ID = :id`,
            {id:id},
            {maxRows : 1, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        wInfo = result.rows[0];
    }catch (e) {
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
    return wInfo;
}
insertNewUser = async function(name,pass){
    let connection;
    let insRows;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `INSERT INTO WUSER (INSTITUTION_NAME,WHITELISTED,CURRENTLY_REGISTERED,PASSWORD,USER_NAME) 
             VALUES (:INSTITUTION_NAME,:WHITELISTED,:CURRENTLY_REGISTERED,:PASSWORD,:USER_NAME)`,
            {INSTITUTION_NAME:name,WHITELISTED:0,CURRENTLY_REGISTERED:0,PASSWORD:'1234',USER_NAME:name},
        );
        insRows = result.rowsAffected;
    }catch (e) {
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
    return insRows;
};
run =function () {
    let objArray = [
        {
            INSTITUTION_ID: 1,
            FIRST_NAME: 'Xad',
            LAST_NAME: 'Cas',
            DATE_OF_BIRTH: '2/4/1994',
            NID_NO: '1234567893',
            CATEGORY_ID: 22
        }
    ];

    insertManyPerson('NID',objArray)
        .then(v=>{
            console.log(v);
        })
        .catch(e=>{
            console.log(e);
        });
};
//run();

module.exports = {
    verifyLogin,
    insertNidUser,
    insertBcfUser,
    insertNewUser,
    insertManyPerson,
    getUserInfoById
};