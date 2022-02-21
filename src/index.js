/*
    probably integrating server and node
*/

const  app = require('./app');
//const  database = require('./models/demoModel');

//var promise =  database.startConnection();

app.listen(app.get('port'),function (){
    console.log('Listening on http://localhost:'+app.get('port')+ '\n' +
    'admin on : http://admin.localhost:'+app.get('port') + '\n'  +
        'center page on : http://localhost:'+app.get('port')+'/center'+'\n'+
        'white list page on : http://localhost:'+app.get('port')+'/white'
    );
});