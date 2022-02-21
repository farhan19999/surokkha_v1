const app = require('express').Router();
const multer = require('multer');
const upload = multer({dest:'src/public/uploads/center/'});
const csvFileHandler = require('../../utils/csvFileHandler');
const userModel = require('../../models/user.model');



app.post('/',upload.single('centerDataFile'),function (req,res){
    //req.file has the file name
    console.log(`file name ${JSON.stringify(req.file)}`);
    csvFileHandler.asyncCenterReadData(req.session.center_id,req.file.filename)
        .then(csvFileHandler.processCenterDataRow)
        .then(v=>{
            userModel.updateHistory({type:'many',array:v})
                .then(()=>{
                    res.send({success:true});
                })
        })
        .catch(e=>{
           throw e;
        });

});

module.exports = app;