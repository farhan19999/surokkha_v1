var oracledb = require('oracledb');
var config = require('../config/database.config');


/**
 *
 *
 *
 */

getCenterInUT  = async function(district, ut){
    let centers = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (   `SELECT vc.CENTER_ID as center_id,vc.CENTER_NAME as title
             FROM VACCINATION_CENTER vc join LOCATION l on(vc.LOCATION_id = l.LOCATION_ID)
             WHERE l.DISTRICT =:district and l.UPAZILLA_OR_THANA = :ut`,
            {district:district, ut : ut},
            {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        let row;
        while((row = await result.resultSet.getRow()))
        {
            centers.push(row);
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
    return centers;
}


validateLogin = async (name, pass) =>{
    let centerInfo;
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `SELECT * FROM VACCINATION_CENTER WHERE USER_NAME = :n AND PASSWORD = :p`,
            { n: name, p :pass},
            {maxRows : 1, outFormat: oracledb.OUT_FORMAT_OBJECT }
        );
        centerInfo = result.rows[0];
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
    return centerInfo;
};


//test function
run = function (){
    //validateLogin('Dhaka Medical College',1234).then(v=>console.log(v)).catch(e=>console.log(e));
};
//run();

module.exports = {
    getCenterInUT,
    validateLogin
};