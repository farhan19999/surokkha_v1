const oracledb = require('oracledb');
const connection_info = require('../config/database.config');

startConnection = async function(){
    let connection;
    try{
        connection =  await oracledb.getConnection(connection_info);
        console.log('Connected to database');
    }catch (err){
        console.log(err);
    }
    finally {
        if(connection)
        {
            try{
                await connection.close();
            }catch (e){console.log(e)}
        }
    }
};

exports.register = async function (user){
    let connection;
    const regId = 2; //have to generate unique id
    try{
        //connection =  await oracledb.getConnection(connection_info);
        const sql = `insert into 
        guser (registration_id,first_name, last_name, nid_no, birth_certificate_no, phone_no, date_of_birth, password, current_address, preferred_hospital, occupation_id,email ) 
        values (`+regId+`,'`+user.first_name+`','`+user.last_name+`',`+ user.nid_number +`,`+user.bs_number+`,`+11111111111+`, to_date('`+user.birthDate.day+`-`+user.birthDate.month+`-`+user.birthDate.year+`','dd-mm-yyyy'),`+user.password+`,`+2+`,`+2+`,`+1+`,`+user.email+`)`;
        //let result = await connection.execute(sql);
        //connection.commit();
        console.log(sql);
    }catch (err){
        console.log(err);
    }
    finally {
        if(connection)
        {
            try{
                await connection.close();
            }catch (e){console.log(e)}
        }
    }
};

printAllLocation = async function ()
{
    let connection;
    try{
        connection =  await oracledb.getConnection(connection_info);
        let result = await connection.execute(`select * from location order by location_id`,[], {resultSet : true, outFormat: oracledb.OUT_FORMAT_OBJECT})
        const rs = result.resultSet;
        let row;
        while((row = await rs.getRow()))
        {
            console.log(row.UPAZILLA_OR_THANA+ " " + row.DISTRICT + " " + row.DIVISION);
        }
        rs.close();
    }catch (err){
        console.log(err);
    }
    finally {
        if(connection)
        {
            try{
                await connection.close();
            }catch (e){console.log(e)}
        }
    }
}

findLocation = async function (connection, data){
    try{
        let sql = `select location_id, upazilla_or_thana, district, division from location`;

        if(data.location_id) sql += ` where location_id = `+data.location_id;
        if(data.upazilla_or_thana) sql += ` where upazilla_or_thana = `+data.upazilla_or_thana;
        if(data.district) sql += ` and district = `+data.district;
        if(data.division) sql += ` and division = `+data.division;
        let result = await connection.execute(sql,[],{resultSet:true,outFormat: oracledb.OUT_FORMAT_OBJECT});
        const rs  = result.resultSet;
        let row;
        let ans = [];
        while(row = await rs.getRow()){ans.add(row)};
        await rs.close();
        return ans;

    }catch(e){console.log(e)};
};
//startConnection();