const app = require('express').Router();
const wModel = require('../../models/wuser.model');
app.get('/',function (req,res){
   if(req.session.authenticated){
       wModel.getUserInfoById(req.session.i_id)
           .then(value => {
               res.render('wHome',{layout :'w_layout',data:value});
           })
           .catch(e=>{
               console.log(e);
               throw e;
           });
       }
   else res.redirect('/white/login');
});



module.exports = app;