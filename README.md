# Surookha_v1

A mirror web application of countrywide  vaccination system [Surokkha](https://www.surokkha.gov.bd) using ORACLE Database Management System(19c).


---
## Languages and Tools

<ul>
  <li>Node.js</li>
  <li>OracleDB</li>
  <li>Bootstrap</li>
  <li>JQuery</li>
</ul>


<br/>

## Prerequisites

**`Oracle`**: As this is primarily an Oracle Database Project, Oracle has to be installed in your system. To install Oracle 19c, follow these steps.
<ol>
  <li>Go <a href="http://www.oracle.com/index.html">here</a> and register for an account of your own.</li>
  <li>Then go <a href="https://www.oracle.com/database/technologies/oracle-database-software-downloads.html">here</a> and install the file according to your system.</li>
  <li>After downloading the ZIP file, UNZIP it and Run setup.exe</li>
  <li>Install properly.</li>
</ol>
<br/>

**`Node.js`**: For this project, you will also need Node.js. Install Node.js from [here](https://nodejs.org/en/download/)



<br/> 

## Installing The Project

Follow the steps below to properly install this project.


<br/>


### Downloading The Project

<ol>
  <li>First, download the <a href="https://github.com/farhan19999/surokkha_v1/archive/refs/heads/master.zip">project</a> as a ZIP file from github into your PC</li>
  <li>Then UNZIP it</li>
</ol>
    OR
<ol>
    <li>Goto your project directory.</li>
    <li>Run the following command.</li>

```sh
    git clone https://github.com/farhan19999/surokkha_v1;
```
<br/>
</ol>


### Setting Up The Database

<ol>
  <li>Go to SQL Plus</li>
  <li>Enter proper user-name and password to login</li>
  <li>Then run command<br/><br/>

   ```sh
   SQL> connect sys as sysdba
   Enter password: password
   ```

</li>
<li>Create a new user. <br/><br/>

	SQL> create user c##{YOUR_USER_NAME} identified by {YOUR_PASSWORD};
	SQL> grant all privileges to c##{YOUR_USER_NAME};

</li>
<li>Now connect to c##{YOUR_USER_NAME}<br/><br/>

	SQL> connect c##{YOUR_USER_NAME}
	Enter password: {YOUR_PASSWORD}

</li>
<li>Run the 'TESTDB1.sql' file from 'sql_dump' folder (/{your project dir}/surookha_v1/sql_dump)<br/><br/>

   ```sh
   SQL> @[path]
   ```

In the place of `[path]` you will have to provide the path of `TESTDB1.sql` in your PC.<br/>

</li>
</ol>
<br/>



### Environment setup
<ol>
    <li>First goto the project folder.</li>
    <li>Then goto   /{your project dir}/surookha_v1/src/config</li>
    <li>Then open database.config.js</li>
</ol>


```sh
    const demo_info = {
    user : {your database user name},
    password : {your database password},
    connectionString : {your database connectionString}
    };
```
You will have to insert proper values in places of
<ul>
  <li>DATABASE_USER_NAME</li>
  <li>DATABASE_USER_PASSWORD</li>
  <li>DATABASE_CONNECTION_STRING</li>
</ul>
<br/>

### Installing NPM Packages

Open cmd and go to the client folder in cmd and run the command

```sh
 npm install
```

<br/>

### Running The Project

Open cmd and go to the project folder in cmd and run the command

```sh
 npm start
```

<br/>

## Creators of This Project

- [**Md. Farhan Mahtab**](https://github.com/farhan19999) - 1805096

- [**Shahriar Ferdous**](https://github.com/Shahriar-Ferdoush) - 18050101

## Disclaimer

This project is inspired by [Surokkha](https://www.surokkha.gov.bd).
Created only for educational purpose.