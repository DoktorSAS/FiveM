$(function () {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "adminmenu") {
            if (item.status == true) {
                $("#container").show();
                $("#home_menu").show();
                $("#player_menu").hide();
                $("#tempban_menu").hide();
                $("#owner_menu").hide();
            } else {
                $("#container").hide();
                $("#player_menu").hide();
                $("#tempban_menu").hide();
                $("#owner_menu").hide();
                $("#home_menu").hide();
            }
        }else if(item.type == "player_menu"){
            var buf = $('#player_warp');
            buf.find('table').html('<tr><th>IN GAME ID</th><th>USERNAME</th></tr>')
            buf.find('table').append(item.html);
            $("#container").show();
            $("#player_menu").show();
            $("#tempban_menu").hide();
            $("#home_menu").hide();
            $("#owner_menu").hide();
        }else if(item.type == "tempban_menu"){
            var buf = $('#tempban_warp');
            buf.find('table').html('<tr><th>DATABASE ID</th><th>USERNAME</th></tr>')
            buf.find('table').append(item.html);
            $("#container").show();
            $("#player_menu").hide();
            $("#tempban_menu").show();
            $("#home_menu").hide();
            $("#owner_menu").hide();
        }else if(item.type == "home_menu"){
            $("#container").show();
            $("#home_menu").show();
            $("#player_menu").hide();
            $("#tempban_menu").hide();
            $("#owner_menu").hide();
        }else if(item.type == "owner_menu"){
            var buf = $('#owner_warp');
            buf.find('table').html('<tr><th>DATABASE ID</th><th>USERNAME</th></tr>')
            buf.find('table').append(item.html);
            $("#container").show();
            $("#home_menu").hide();
            $("#player_menu").hide();
            $("#tempban_menu").hide();
            $("#owner_menu").show();
        }else{
            $("#container").show();
            $("#home_menu").show();
            $("#player_menu").hide();
            $("#tempban_menu").hide();
            $("#owner_menu").hide();
        }
        return
    })
    function display(bool) {
        if (bool) {
            $("#container").show();
            $("#home_menu").show();
            $("#player_menu").hide();
            $("#tempban_menu").hide();
            $("#owner_menu").hide();
        } else {
            $("#container").hide();
            $("#player_menu").hide();
            $("#tempban_menu").hide();
            $("#home_menu").hide();
            $("#owner_menu").hide();
        }
    }
    display(false)

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://sx_adminmenu/exit', JSON.stringify({}));
            return
        }
    };
    $("#search_player").click(function () {
        $.post(`http://sx_adminmenu/reloadlist`, JSON.stringify({
            submenu: "player_menu",
            username: $('#player_to_search').val()
        }));
    })
    
    $("#search_player_ban").click(function () {
        $.post(`http://sx_adminmenu/reloadlist`, JSON.stringify({
            submenu: "tempban_menu",
            username: $('#player_to_search_tb').val()
        }));
    })
    $("#search_player_permban").click(function () {
        $.post(`http://sx_adminmenu/reloadlist`, JSON.stringify({
            submenu: "owner_menu",
            username: $('#player_to_search_tbo').val()
        }));
    })

    
    
    $("#player_hide").click(function () {
        $.post(`http://sx_adminmenu/loadsubmenu`, JSON.stringify({
            submenu: "player_menu",
        }));
    })
    $("#tempban_hide").click(function () {
        $.post(`http://sx_adminmenu/loadsubmenu`, JSON.stringify({
            submenu: "tempban_menu"
        }));
    })
    $("#home_hide").click(function () {
        $.post(`http://sx_adminmenu/loadsubmenu`, JSON.stringify({
            submenu: "home_menu"
        }));
    })
    $("#owner_hide").click(function () {
        $.post(`http://sx_adminmenu/loadsubmenu`, JSON.stringify({
            submenu: "owner_menu"
        }));
    })

    

    $("#KICK").click(function () {
        if($('#player').val() != "" && $('#reason').val() != ""){
            $.post(`http://sx_adminmenu/commands`, JSON.stringify({
                command: "KICK",
                target: $('#player').val(),
                reason: $('#reason').val()
            }));
        }else{
            $.post(`http://sx_adminmenu/error`, JSON.stringify({
                text: "Missing Parameter"
            }));
        }
       
    })
    $("#WARN").click(function () {
        if($('#player').val() != "" && $('#reason').val() != ""){
            $.post(`http://sx_adminmenu/commands`, JSON.stringify({
                command: "WARN",
                target: $('#player').val(),
                reason: $('#reason').val()
            }));
        }else{
            $.post(`http://sx_adminmenu/error`, JSON.stringify({
                text: "Missing Parameter"
            }));
        }
       
    })

    $("#TPTO").click(function () {
        if($('#player_name').val() != ""){
            $.post(`http://sx_adminmenu/commands`, JSON.stringify({
                command: "TPTO",
                target: $('#player_name').val(),
            }));
        }else{
            $.post(`http://sx_adminmenu/error`, JSON.stringify({
                text: "Missing Parameter"
            }));
        }
    })

    $("#TPME").click(function () {
        if($('#player_name').val() ){
            $.post(`http://sx_adminmenu/commands`, JSON.stringify({
                command: "TPME",
                target: $('#player_name').val(),
            }));
        }else{
            $.post(`http://sx_adminmenu/error`, JSON.stringify({
                text: "Missing Parameter"
            }));
        }
       
    })
    $("#TEMPBANNAME").click(function () {
            $.post(`http://sx_adminmenu/commands`, JSON.stringify({
                command: "TEMPBANNAME",
                target: $('#player_name_tb').val(),
                reason: $('#reason_tb').val(),
                time: $('#time').val(),
                type: $('#type').val()
            }));
    })
    $("#TEMPBANID").click(function () {
        $.post(`http://sx_adminmenu/commands`, JSON.stringify({
            command: "TEMPBANNAME",
            target: $('#player_name_tb').val(),
            reason: $('#reason_tb').val(),
            time: $('#time').val(),
            type: $('#type').val()
        }));
    })

    $("#SETRANK").click(function () {
        $.post(`http://sx_adminmenu/commands`, JSON.stringify({
            command: "SETRANK",
            target: $('#player_db_id').val(),
            level: $('#player_level').val(),
        }));
    })

    $("#UNBAN").click(function () {
        $.post(`http://sx_adminmenu/commands`, JSON.stringify({
            command: "UNBAN",
            target: $('#player_db_id_end').val(),
        }));
    })

    $("#BAN").click(function () {
        $.post(`http://sx_adminmenu/commands`, JSON.stringify({
            command: "BAN",
            target: $('#player_db_id_end').val(),
        }));
    })
    
})
