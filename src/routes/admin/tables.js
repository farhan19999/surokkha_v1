var route = require('express').Router();
var locationModel = require('../../models/location.model');
var vaccineModel = require('../../models/vaccine.model');
var wModel = require('../../models/wuser.model');

//todo : have to show other table : user, vaccination center, user dosage history
route.get('/location',function (req,res){
   locationModel.loadAllLocation()
       .then(r=>{
          if(!res.locals.partials)res.locals.partials = {};
          res.locals.partials.table = r;
          res.locals.partials.formData = locationModel.formData;
          res.render('admin_table',{layout:'admin_layout',title:'LOCATION'})
       })
       .catch(e=>{
            throw e;
       });
});

route.post('/location',function (req,res){
   //autoCommit is turned off
   //check validity of data to be modified
   locationModel.insertLocation(req.body)
       .then(r=>{
           res.json({
               msg : 'success',
               index: r
           });
        })
       .catch(e=>{
      throw e;
   });
});

route.put('/location',function (req,res){
   locationModel.updateLocation(req.body)
       .then(()=>{
            res.send({success:true});
        })
       .catch(e=>{throw e});
});

route.delete('/location',function (req,res){
   //autoCommit is turned off
   //so refreshing the webpage will put back the data
   locationModel.deleteLocation(req.body)
       .then(()=>{
           res.json({
               msg:'success'
           });
        })
       .catch(e=>{throw e});
});


route.get('/vaccine',function (req,res){
    vaccineModel.loadAllVaccine()
        .then(r=>{
            if(!res.locals.partials)res.locals.partials = {};
            res.locals.partials.table = r;
            res.locals.partials.formData = vaccineModel.formData;
            res.render('admin_table',{layout:'admin_layout',title:'VACCINE'})
        })
        .catch(e=>{
            throw e;
        });
});

route.post('/vaccine',function (req,res){
    //autoCommit is turned off
    //check validity of data to be modified
    vaccineModel.insertVaccine(req.body)
        .then(r=>{
            res.json({
                msg : 'success',
                index: r
            });
        })
        .catch(e=>{
            throw e;
        });
});

route.put('/vaccine',function (req,res){
    vaccineModel.updateVaccine(req.body)
        .then(()=>{
            res.send({success:true});
        })
        .catch(e=>{
            res.send({success:false, msg : e});
            throw e;
        });
});

route.delete('/vaccine',function (req,res){
    //autoCommit is turned off
    //so refreshing the webpage will put back the data
    locationModel.deleteLocation(req.body)
        .then(()=>{
            res.json({
                msg:'success'
            });
        })
        .catch(e=>{throw e});
});


route.get('/whitelist_user',function (req,res){
    wModel.loadAllUser()
        .then(r=>{
            if(!res.locals.partials)res.locals.partials = {};
            res.locals.partials.table = r;
            res.locals.partials.formData = wModel.formData;
            res.render('admin_table',{layout:'admin_layout',title:'WhiteList'})
        })
        .catch(e=>{
            throw e;
        });
});

route.post('/whitelist_user',function (req,res){
    wModel.insertNewUser(req.body.USER_NAME,req.body.PASSWORD)
        .then(r=>{
            res.json({
                msg : 'success',
                index: r
            });
        })
        .catch(e=>{
            res.json({
                msg:'failed',
                error : e
            })
        });
});

route.put('/whitelist_user',function (req,res){
    wModel.updateUser(req.body)
        .then(()=>{
            res.send({success:true});
        })
        .catch(e=>{
            res.send({success:false, msg : e});
            throw e;
        });
});

module.exports = route;