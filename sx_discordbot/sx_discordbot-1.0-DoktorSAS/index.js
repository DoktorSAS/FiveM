
/*
    Code Developed by DoktorSAS - Join in Sorex Discord To Report Any BUGS
    Version 1.0
    Description: This is a simple system to mange multi account of players, with this system
                 it's really hard for a hacker to steal another user's identity...

    For more info about SXAdminTool look the website or Join in the comunity:
    Discord: https://discord.io/Sorex on google, Discord.gg/nCP2y4J on discord or https://discord.com/invite/nCP2y4J
    Twitter: @SorexProject -> https://twitter.com/SorexProject
    Instagram: @SorexProject -> https://www.instagram.com/sorexproject/
    Youtube: SorexProject -> https://www.youtube.com/channel/UCP1SC3K8rg3fLAeRFlkM6cg
    
    If you want Donate to the project Donate to https://www.paypal.me/SorexProject 

    PS:
    Don't remove credits and don't try to sell the code to someone else, don't be an asshole scammer.
    I made this code to help the others, is a free tool with opensource to all
*/

const Discord = require('discord.js');
const bot = new Discord.Client();
const mysql = require('mysql');
var logChannel = "FoveM-Log"
const connection = mysql.createConnection({
  host     : 'localhost', //If you don't host the database on the same machine change localhost with the ip og the machine with the database
  port     : '3306', //If you use another port different then the defaul 3306 change it
  user     : 'root', //If your root name is anorher change the name
  password : '', //If you use password for the DB remeber to use it there
  database : 'sx_database', //if you don't use this database remember to change it
  charset : 'utf8mb4'
});

connection.connect(err => {
    console.log("SXAdminBot v1.0")
    console.log("Discord: Discord.ioSorex on google or https://discord.gg/nCP2y4J")
    console.log("Developed by DoktorSAS")
    console.log("============================================================================================")
    if(err) throw err;
    else{
    console.log("[SXAdminBot] Connected to the Database")
    console.log("[SXAdminBot] Loaded")
    }
});


const token = 'YOURTOKEN';

bot.on('ready', () =>{
    console.log('[SXAdmin] Account Manager BOT is now Online');
    
});

const prefix = 'sx!';

bot.on('message', message =>{

    const args = message.content.substring(prefix.length).split(" ");
    switch(args[0]){
        //Help Commands
        case 'help':
        case 'h':
        message.channel.send('**SXAdmin HELP** There a list of commands: \n sx!verifyme {username} {password}');
        break;
        case 'verifyme':
            message.delete(1000);
            if (args[1] != null && args[2] != null){
            connection.query(`SELECT pin FROM sx_users WHERE username LIKE '`+args[1]+`' AND password LIKE '`+args[2]+`'`, function (err, res) {
            message.author.send('**Thanks for Playing on This Server**\n**Your PIN: ** ' + res[0].pin);
            })
            }else
            message.channel.send('**ERROR Missing Parameter**\n**Syntax: ** sx!verifyme {username} {password}');
        break;
        case 'init':
            message.guild.channels.create(logChannel);
        break;
        }
});

bot.login(token);
