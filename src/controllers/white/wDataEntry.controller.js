const app = require('express').Router();
const wModel = require('../../models/wuser.model');
const categoryModel = require('../../models/category.model');
const csvFileHandler = require('../../utils/csvFileHandler');
const multer = require('multer');
const upload = multer({dest:'src/public/uploads/white/'});

app.get('/',function (req,res){
    if(req.session.authenticated){
        categoryModel.loadAllCategory()
            .then(v=>{
                res.render('wDataEntry',{layout:'w_layout',category:v.sector});
            })
            .catch(e=>{
                throw e;
            });
    }
    else{
        res.redirect('/white/login');
    }

});

app.post('/process_nid',function (req,res){
    if(req.session.authenticated){
        let {nid, dob, fname, lname, sector_id} = req.body;
        let data = {sector_id : sector_id};
        if(req.body.sub_sector_id)data.sub_sector_id = req.body.sub_sector_id;
        categoryModel.findCategoryId(data)
            .then(id=>{
                wModel.insertNidUser(req.session.i_id,nid,dob,fname,lname,id)
                    .then(value => {
                        if(value === 1){
                            res.send({success:true});
                        }
                        else res.send({success:false, message : ''});
                    });
            })
            .catch(e=>{
                console.log(e);
                throw e;
            });
    }
    else{
        res.redirect('/white/login');
    }

});

app.post('/process_bcf',function (req,res){
    if(req.session.authenticated){
        let {bcf, dob, fname, lname} = req.body;

        wModel.insertBcfUser(req.session.i_id,bcf,dob,fname,lname)
            .then(value => {
                if(value === 1){
                    res.send({success:true});
                }
                else res.send({success:false, message : ''});
            })
            .catch(e=>{
                console.log(e);
                throw e;
            });
    }
    else{
        res.redirect('/white/login');
    }
});

app.post('/process_csv/:type',upload.single('wDataFile'),function (req,res){
    //req.file has the file name
    //console.log(`file name ${JSON.stringify(req.file)}`);
    if(req.params.type === 'NID'){
        csvFileHandler.asyncWhiteReadData(req.session.i_id,req.file.filename,req.params.type)
            .then(value => {
                csvFileHandler.processInstDataRow(value)
                .then(v=>{
                    wModel.insertManyPerson(req.params.type,v)
                        .then(v2=>{
                            res.send({success:true, msg:`${v2} rows inserted`});
                        })
                        .catch(e=>{
                            throw e;
                        });
                })
                .catch(e=>{
                    throw e;
                });
            })
            .catch(e=>{
                res.send({success:false,msg:'Wrong Data format'});
            });
    }
    else {
        csvFileHandler.asyncWhiteReadData(req.session.i_id,req.file.filename,req.params.type)
            .then(value => {
                wModel.insertManyPerson(req.params.type,v)
                    .then(v2=>{
                        res.send({success:true, msg:`${v2} rows inserted`});
                    })
                    .catch(e=>{
                        throw e;
                    });
            })
            .catch(e=>{
                res.send({success:false,msg:'Wrong Data format'});
            });
    }
});

module.exports = app;