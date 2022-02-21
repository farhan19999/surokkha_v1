let enrollType = [
    { id: 1, title: 'Citizen registration (18 years & above)', value: 'general' },
    { id: 2, title: 'All officers and employees of the Government Health and Family Planning Department', value: 'govt_health' },
    { id: 3, title: 'Approved private health and family planning officers-employees', value: 'reg_pvt_health' },
    { id: 4, title: 'All directly involved government and private health care officers-employees', value: 'reg_pvt_health' },
    { id: 5, title: 'Heroic freedom fighters and heroines', value: '5' },
    { id: 6, title: 'Front-line law enforcement agency', value: '6' },
    { id: 7, title: 'Military and paramilitary defense forces', value: '7' },
    { id: 24, title: 'Civilian Aircraft', value: '24' },
    { id: 8, title: 'Essential Offices for governance the state', value: '8' },
    { id: 31, title: 'Bar Council Registrar Attorney', value: '31' },
    { id: 23, title: 'Educational Institutions', value: '23' },
    { id: 9, title: 'Front-line media workers', value: '9' },
    { id: 10, title: 'Elected Public representative', value: '10' },
    { id: 11, title: 'Front-line officers and employees of City Corporation and the municipality', value: '11' },
    { id: 12, title: 'Religious Representatives (of all religions)', value: '12' },
    { id: 13, title: 'Engaged in burial', value: '13' },
    { id: 14, title: 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', value: '14' },
    { id: 15, title: 'Government officials and employees of railway stations, airports, Land ports and seaports', value: '15' },
    { id: 16, title: 'Government officials and employees involved in emergency public service in districts and upazilas', value: '16' },
    { id: 17, title: 'Bank officer-employee', value: '17' },
    { id: 32, title: 'Farmer', value: '32' },
    { id: 33, title: 'Workers', value: '33' },

    { id: 19, title: 'National players', value: '19' },
    { id: 25, title: 'Students in medical education related subjects', value: '25' },
    { id: 26, title: 'Student 18 years and above', value: '26' },
    { id: 28, title: 'Person with disability', value: '28' }
];
let enrollSubType = {
    '2': [
        { id: 1, title: 'Doctor', value: '' },
        { id: 2, title: 'Nurse and Midwife', value: '' },
        { id: 3, title: 'Medical Technologist', value: '' },
        { id: 4, title: 'Cleaning staff', value: '' },
        { id: 5, title: 'Physiotherapist and related staff', value: '' },
        { id: 6, title: 'Conventional and complementary medical personnel', value: '' },
        { id: 7, title: 'Community health workers', value: '' },
        { id: 52, title: 'Administrative', value: '' },
        { id: 8, title: 'Ambulance driver', value: '' },
        { id: 53, title: 'Others', value: '' }
    ],
    '3': [
        { id: 9, title: 'Doctor', value: '' },
        { id: 10, title: 'Nurse and Midwife', value: '' },
        { id: 11, title: 'Medical Technologist', value: '' },
        { id: 12, title: 'Cleaning staff', value: '' },
        { id: 13, title: 'Physiotherapist and related staff', value: '' },
        { id: 14, title: 'Conventional and complementary medical personnel', value: '' },
        { id: 15, title: 'Health workers', value: '' },
        { id: 16, title: 'Ambulance driver', value: '' }
    ],
    '4': [
        { id: 17, title: 'Health administration', value: '' },
        { id: 18, title: 'All staff involved in management', value: '' },
        { id: 19, title: 'Clerk', value: '' },
        { id: 20, title: 'Industrial and trade workers', value: '' },
        { id: 21, title: 'Laundry and cooking staff', value: '' },
        { id: 22, title: 'Driver', value: '' }
    ],
    '6': [
        { id: 54, title: 'DGFI', value: '' },
        { id: 23, title: 'Police', value: '' },
        { id: 24, title: 'Traffic police', value: '' },
        { id: 25, title: 'Rapid Action Battalion (RAB)', value: '' },
        { id: 26, title: 'Ansar', value: '' },
        { id: 49, title: 'NSI', value: '' },
        { id: 27, title: 'VDP', value: '' },
        { id: 31, title: 'Border Guard Bangladesh (BGB)', value: '' },
        { id: 32, title: 'Coast Guard', value: '' }
    ],
    '7': [
        { id: 28, title: 'Army', value: '' },
        { id: 29, title: 'Navy', value: '' },
        { id: 30, title: 'Air Force', value: '' },
        { id: 33, title: 'Presidential Guard Regiment', value: '' }
    ],
    '8': [
        { id: 34, title: 'Ministry', value: '' },
        { id: 35, title: 'Secretariat', value: '' },
        { id: 36, title: 'Judicial', value: '' },
        { id: 37, title: 'Administrative', value: '' },
        { id: 51, title: 'Officers and employees of the directorates', value: '' },
        { id: 55, title: 'State-owned corporations and companies', value: '' }
    ],
    '9': [
        { id: 38, title: 'Journalist', value: '' },
        { id: 39, title: 'Media personnel', value: '' }
    ],
    '14': [
        { id: 40, title: 'Emergency electrical workers', value: '' },
        { id: 41, title: 'Gas supply workers', value: '' },
        { id: 42, title: 'Water supply staff', value: '' },
        { id: 43, title: 'Sewerage workers', value: '' },
        { id: 44, title: 'Fire service personnel', value: '' },
        { id: 45, title: 'Transport workers', value: '' }
    ],
    '15': [
        { id: 46, title: 'Naval Government Officers-Employees', value: '' },
        { id: 47, title: 'Railway station Government Officers-Employees', value: '' },
        { id: 48, title: 'Biman Government Officers-Employees', value: '' },
        { id: 56, title: 'Land ports Government Officers-Employees', value: '' }
    ],
    '23': [
        { id: 57, title: 'Teacher', value: '' },
        { id: 58, title: 'Officers-Employees', value: '' }
    ],
    '24': [
        { id: 59, title: 'Pilot', value: '' },
        { id: 60, title: 'Cabin Crew', value: '' },
        { id: 61, title: 'Others', value: '' }
    ],
    '25': [
        { id: 62, title: 'Public / private medical / dental college students', value: '' },
        { id: 63, title: 'Government Nursing Midwifery College / Institute student', value: '' },
        { id: 64, title: 'Student of Government IHT', value: '' },
        { id: 65, title: 'Student of Government MATS', value: '' }
    ]
};


comb =  function (){
    let array = [];
    for(var i = 0 ; i<enrollType.length ; i++ )
    {
        let key = ''+ enrollType[i].id;
        if(enrollSubType[key])
        {
            let sub = enrollSubType[key];
            sub.forEach(e=>{
                var obj = {};
                obj['SECTOR_ID'] = enrollType[i].id;
                obj['SECTOR_NAME'] = enrollType[i].title;
                obj['SUB_SECTOR_ID'] = e.id;
                obj['SUB_SECTOR_NAME'] = e.title;
                array.push(obj);
            });
        }
        else array.push({
            SECTOR_ID:enrollType[i].id,
            SECTOR_NAME : enrollType[i].title
        });
    }
    //console.log(array);
    return array;
}

module.exports = {comb};