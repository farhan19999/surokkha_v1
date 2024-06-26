var oracledb = require('oracledb');
var config = require('../config/database.config');

verifyPreReg = async function (data)
{
    let name = {};
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute
        (
            `SELECT FIRST_NAME, LAST_NAME FROM AFFILIATION WHERE NID_NO = :nid AND DATE_OF_BIRTH = to_date(:dob,'yyyy-mm-dd') AND CATEGORY_ID = :category_id  `,
            data,
            {maxRows : 1, outFormat: oracledb.OUT_FORMAT_OBJECT}
        );
        name = result.rows[0];
        //console.log(result.rows[0]);
        //row = locationMap(result.metaData, result.rows[0]);
    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
    return name;
}
run = function (){
    verifyPreReg({nid:1234567899, dob:'2000-02-01', category_id : 22}).then(value => {console.log(value)}).catch(e=>console.log(e));

};
//run();

module.exports ={
  verifyPreReg
};