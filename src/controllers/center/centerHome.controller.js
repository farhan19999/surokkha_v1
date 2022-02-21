var app = require('express').Router();
var centerModel = require('../../models/center.model');
var userModel = require('../../models/user.model');
var vaccineModel = require('../../models/vaccine.model');
app.get('/',function (req,res){
    if(req.session.authenticated)res.render('centerHome',{layout : 'center_layout', center:{name:req.session.center_name, capacity :req.session.center_cap}});
    else res.redirect('/center/login');
});
app.get('/sign_out',function (req,res){
    if(req.session.authenticated){
        req.session.destroy();
    }
    res.redirect('/center/login');
});
app.get('/entry',function (req,res){
    if(req.session.authenticated){
        vaccineModel.loadAllVaccine()
            .then(v=>{
                let {tableData} = v;
                //console.log(tableData);
                res.render('centerDataEntry',{layout : 'center_layout', vaccine : tableData}); // vaccine ={vaccine_id,vaccine_name,mf_name}
            })
            .catch(e=>{throw e;});
    }
    else res.redirect('/center/login');
});
app.post('/entry',function (req,res){
    //console.log(req.session);
    if(req.session.authenticated)
    {
        let {reg_id, nid, bcf, dob, gDate, batch_no, vaccineId, dose_no} = req.body;
        //console.log(req.body);
        //maybe verify with nid/bcf, dob, regId
        let data = {type: 'single'};
        data.obj = {reg_id:reg_id, centerId :req.session.center_id, gDate:gDate, batch_no:batch_no, vaccineId:vaccineId, dose_no:dose_no};

        userModel.updateHistory(data)
            .then(v=>{
                res.send({success: true});
            })
            .catch(e=>{
                throw e;
            });
    }
    else
    {
        res.json ({status:'redirect', url:'/center/login'});
    }

});

module.exports = app;