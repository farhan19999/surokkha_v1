var oracledb = require('oracledb');
var config = require('../config/database.config');

/**
 * data={
 *     nid :
 *     bcf :
 *     dob :
 *     category_id :
 *
 * }
 *
 */

findUser = async function(uid,type,dob,password){
    let connection;
    let data = {DATE_OF_BIRTH:dob};
    let nid,bcf,user;
    let sql1 = `SELECT * FROM GUSER WHERE DATE_OF_BIRTH = to_date(:DATE_OF_BIRTH,'yyyy-mm-dd')`;

    if(type ==='NID')
    {
        sql1 += ` AND NID_NO = :NID_NO`;
        data.NID_NO = uid;
    }
    else if(type === 'BCF')
    {
        sql1 += ` AND BIRTH_CERTIFICATE_NO = :BIRTH_CERTIFICATE_NO`;
        data.BIRTH_CERTIFICATE_NO = uid;
    }
    if(password !== ''){
        sql1 += ` AND PASSWORD = :PASSWORD`;
        data.PASSWORD = password;
    }
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(
            sql1,
            data,
            {
                maxRows :1,
                outFormat: oracledb.OUT_FORMAT_OBJECT
            }
        );
        user = result.rows;
    }catch (e){
        console.log('Error in finding user in db....');
        console.log(e);
    }finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
    return user;
};

registerUserInDB = async function (user) {
    let sql = '(FIRST_NAME, LAST_NAME, PHONE_NO, DATE_OF_BIRTH, CATEGORY_ID, EMAIL, CURRENT_ADDRESS, PREFERRED_CENTER, HBP_HD_STR, DIABETICS, KD, RESP, CANCER, PREV_COVID';
    let sql2 = ` values (:FIRST_NAME, :LAST_NAME, :PHONE_NO, to_date(:DATE_OF_BIRTH,\'yyyy-mm-dd\'), :CATEGORY_ID, :EMAIL, :CURRENT_ADDRESS, :PREFERRED_CENTER, :HBP_HD_STR, :DIABETICS, :KD, :RESP, :CANCER, :PREV_COVID `;
    let data = {FIRST_NAME : user.fn, LAST_NAME : user.ln, PASSWORD : user.pwd, PHONE_NO : user.ph_num, DATE_OF_BIRTH:user.dob, CATEGORY_ID : user.category_id, EMAIL : user.email, CURRENT_ADDRESS : user.location_id, PREFERRED_CENTER : user.prefCenter, HBP_HD_STR:user.hbp, DIABETICS : user.dbts, KD : user.kd, RESP : user.resp, CANCER: user.cancer, PREV_COVID : user.prev_cov};
    if(user.regType === 'NID')
    {
        sql += `, NID_NO) `;
        sql2 +=`, :NID_NO)`;
        data.NID_NO =  user.nid;
    }
    else if(user.regType === 'BCF')
    {
        sql += ', BIRTH_CERTIFICATE_NO)'
        sql2 +=`, :BIRTH_CERTIFICATE_NO)`;
        data.BIRTH_CERTIFICATE_NO =  user.bcf;
    }
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(
            `INSERT INTO GUSER `+sql+sql2,
            data,
            {autoCommit : true}
        );
        //console.log('result is : ' + result);
        //console.log(`INSERT INTO GUSER`+sql+sql2)
    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
}

updateHistory = async (data)=> {
    let connection;
    //console.log(reg_id+' '+centerId+' '+batch_no+' '+date+' '+vaccineId+' '+dose_no);
    try{
        connection = await oracledb.getConnection(config);
        let result ;
        console.log(data);
        if(data.type ==='single'){
            let {reg_id, centerId, batch_no, gDate, vaccineId, dose_no} = data.obj;
            result = await connection.execute(
                `INSERT INTO USER_DOSAGE_HISTORY(REGISTRATION_ID, VACCINE_ID, DOSE_NO, CENTER_ID, BATCH_NO, GIVEN_DATE)
            values (:REGISTRATION_ID, :VACCINE_ID, :DOSE_NO, :CENTER_ID, :BATCH_NO, to_date(:GIVEN_DATE,'yyyy-mm-dd') )`,
                {REGISTRATION_ID: reg_id, VACCINE_ID : vaccineId, DOSE_NO : dose_no, CENTER_ID : centerId, BATCH_NO: batch_no, GIVEN_DATE : gDate },
                {
                    autoCommit : true
                }
            );
        }
        else if(data.type === 'many'){
            result = await connection.executeMany(
                `INSERT INTO USER_DOSAGE_HISTORY(REGISTRATION_ID, VACCINE_ID, DOSE_NO, CENTER_ID, BATCH_NO, GIVEN_DATE)
            values (:REGISTRATION_ID, :VACCINE_ID, :DOSE_NO, :CENTER_ID, :BATCH_NO, to_date(:GIVEN_DATE,'mm/dd/yyyy') )`,
                data.array,
                {
                    autoCommit : true
                }
            );
        }

    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
};

findUserHistory = async function(uid){
    let history = [];
    let connection;
    try{
        connection = await oracledb.getConnection(config);
        let result = await connection.execute(
          `SELECT UDH.DOSE_NO AS DOSE_NO, to_char(UDH.GIVEN_DATE,'dd/mm/yyyy') AS GIVEN_DATE, VC.CENTER_NAME AS CENTER, V.VACCINE_NAME AS VACCINE_NAME 
           FROM USER_DOSAGE_HISTORY UDH JOIN VACCINE V ON(UDH.VACCINE_ID = V.VACCINE_ID) JOIN VACCINATION_CENTER VC ON(UDH.CENTER_ID = VC.CENTER_ID)
           WHERE UDH.REGISTRATION_ID = :t`,
           [uid],
            {
                resultSet : true,
                outFormat: oracledb.OUT_FORMAT_OBJECT
            }
        );
        let row;
        while((row = await result.resultSet.getRow())){
            history.push(row);
        }
        await result.resultSet.close();

    }catch (e){console.log(e);}
    finally {
        try{
            await connection.close();
        }
        catch (e){console.log(e);}
    }
    return history;
}



run = function (){
    /*updateHistory({type:'many',array: [
            {
                CENTER_ID : 1,
                REGISTRATION_ID: 1,
                VACCINE_ID: 1,
                DOSE_NO: 1,
                BATCH_NO: 1234,
                GIVEN_DATE: '9/1/2021',
            }
        ]})
        .then()
        .catch(e=>{console.log(e);});
     */
    //findUser(1234567890,'NID','2000-02-01').then(v=>console.log(v)).catch(e=>console.log(e));
    findUserHistory(1).then(v=>console.log(v));
};
run();

module.exports ={
    registerUserInDB,
    updateHistory,
    findUser,
    findUserHistory
};