const fs = require('fs');
const path = require('path');
const csv = require('fast-csv');
const Q = require('q');

const vaccineModel = require('../models/vaccine.model');
const categoryModel = require('../models/category.model');

processCenterDataRow = async function (objArray){
    return new Promise((resolve,reject)=>{
        var promises = [];
        let newObjArray = [];
        objArray.forEach(row=> {
            var deferred = Q.defer();
            let obj = {
                CENTER_ID : row.CENTER_ID,
                REGISTRATION_ID: row.REGISTRATION_ID,
                GIVEN_DATE: row.GIVEN_DATE,
                BATCH_NO: row.BATCH_NO,
                DOSE_NO: row.DOSE_NO
            };
            vaccineModel.findVaccineID(row.VACCINE_NAME, row.MANUFACTURER)
                .then(v => {
                    obj.VACCINE_ID = v.VACCINE_ID;
                    newObjArray.push(obj);
                    deferred.resolve();
                })
                .catch(e => {
                    console.log(e);
                });
            promises.push(deferred.promise);
        });
        Q.all(promises).then(()=>resolve(newObjArray)).catch(e=>reject(e));
    });
}

asyncCenterReadData = async function (center_id,filename) {
    let headerArray = ['REGISTRATION_ID', 'VACCINE_NAME', 'MANUFACTURER','GIVEN_DATE', 'BATCH_NO', 'DOSE_NO'];
    return new Promise((resolve,reject)=>{
        let objArray=[];
        fs.createReadStream(path.resolve(path.join(__dirname,'../'), 'public/uploads/center', filename))
            .pipe(csv.parse({ headers: headerArray,renameHeaders:true }))
            .on('error', error => reject(error))
            .on('data',row=>{
                row.CENTER_ID = center_id;
                objArray.push(row);
            })
            .on('end', rowCount => {
                //console.log(`Parsed ${rowCount} rows`);
                resolve(objArray);
            });
    });
};


asyncWhiteReadData = async function (i_id,filename,type) {
    let headerArray
    if(type==='NID'){
        headerArray = ['FIRST_NAME', 'LAST_NAME', 'DATE_OF_BIRTH', 'NID_NO', 'SECTOR_NAME', 'SUB_SECTOR_NAME'];
    }
    else {
        headerArray = ['FIRST_NAME', 'LAST_NAME', 'DATE_OF_BIRTH', 'BIRTH_CERTIFICATE_NO'];
    }
    return new Promise((resolve,reject)=>{
            let objArray=[];
            fs.createReadStream(path.resolve(path.join(__dirname,'../'), 'public/uploads/white', filename))
                .pipe(csv.parse({ headers: headerArray,renameHeaders:true }))
                .on('error', error => reject(error))
                .on('data',row=>{
                    row.INSTITUTION_ID = i_id;
                    if(type === 'BCF')row.CATEGORY_ID = 99;
                    objArray.push(row);
                })
                .on('end', rowCount => {
                    //console.log(`Parsed ${rowCount} rows`);
                    resolve(objArray);
                });
        });
};

processInstDataRow = async function (objArray){
    return new Promise((resolve,reject)=>{
        var promises = [];
        let newObjArray = [];
        objArray.forEach(row=> {
            var deferred = Q.defer();
            let obj = {
                INSTITUTION_ID : row.INSTITUTION_ID,
                FIRST_NAME : row.FIRST_NAME,
                LAST_NAME:row.LAST_NAME,
                DATE_OF_BIRTH:row.DATE_OF_BIRTH,
                NID_NO: row.NID_NO
            };
            categoryModel.findCategoryIdFromName({SECTOR_NAME:row.SECTOR_NAME, SUB_SECTOR_NAME:row.SUB_SECTOR_NAME})
                .then(v => {
                    obj.CATEGORY_ID  = v.CATEGORY_ID;
                    newObjArray.push(obj);
                    deferred.resolve();
                })
                .catch(e => {
                    console.log(e);
                });
            promises.push(deferred.promise);
        });
        Q.all(promises).then(()=>resolve(newObjArray)).catch(e=>reject(e));
    });
}



run = function (){
    asyncWhiteReadData(1,'csv1.csv','NID')
        .then(processInstDataRow)
        .then(v=>console.log(v))
        .catch(e=>console.log(e));
};
//run();

module.exports = {
    asyncCenterReadData,
    processCenterDataRow,
    asyncWhiteReadData,
    processInstDataRow
}