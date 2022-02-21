const oracledb = require('oracledb');

const tableInfo = {
    tableName : 'My_user2',
    column : [
        {name: 'id', type : 'number(1000)'},
        {name: 'Name', type: 'varchar2(50)'}
    ],
    primaryKeys : ['id'],
    foreignKeys : [{keys : ['name'], ref : 'SomeTable', fkeys : ['f_name']}]
};

createTableSQL = function (tableInfo){


    let sql = 'Create table '+ tableInfo.tableName + '(';
    for (let i = 0; i < tableInfo.column.length; i++){
        const column = tableInfo.column[i];
        sql += column.name + ' ' + column.type + ' ,';
    }


    sql += 'primary keys(';
    for (let i = 0; i < tableInfo.primaryKeys.length; i++){
        const column = tableInfo.primaryKeys[i];
        sql += column;
        if(i !== tableInfo.primaryKeys.length-1)sql += ',';
        else sql += ')';
    }


    if(tableInfo.foreignKeys)
    {
        sql += ',Foreign key(';
        for (let i = 0; i < tableInfo.foreignKeys.length; i++){
            let column = tableInfo.foreignKeys[i];

            for (let j = 0; j < column.keys.length; j++){
                const Key = column.keys[j];
                sql += Key;
                if(j !== column.keys.length-1)sql += ',';
                else sql+=')';
            }

            sql += ' References ' + column.ref +'( ';

            for (let j = 0; j < column.fkeys.length; j++){
                const Fkey = column.fkeys[j];
                sql += Fkey;
                if(j !== column.fkeys.length-1)sql += ',';
                else sql+=')';
            }
        }
        sql +=')';
    }

    return sql;
};

combine_data= function (category,subCategory)
{

}


insertDataSql = function (table_name, column_names, data ) {
    let sql = 'Insert into '+ table_name;

    for(let i = 0; i<column_names.length ; i++)
    {
        if(i === 0)sql += '(';
        sql += column_names[i];
        if(i !== column_names.length-1)sql += ',';
        else sql += ')';
    }

    sql += ' VALUES ';

    for(let i = 0; i<data.length ; i++)
    {
        if(i === 0)sql += '(';
        sql += data[i];
        if(i !== data.length-1)sql += ',';
        else sql += ')';
    }

};


