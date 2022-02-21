/*
get value from db
update db
all functions we want for each req
*/
const pageInfo = require('../config/page.config');

exports.getHomePage = function (req,res)
{
    //res.send(message);
    res.render('home', pageInfo.home);
}