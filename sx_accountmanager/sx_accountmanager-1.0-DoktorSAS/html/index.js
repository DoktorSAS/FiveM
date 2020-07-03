$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
            $("#video").show();
        } else {
            $("#container").hide();
            $("#reg").hide();
            $("#pin").hide();
            $("#video").hide();
        }
    }
    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }else if (item.type === "pin") {
            $("#container").hide();
            $("#reg").hide();
            $("#pin").show();
            $("#video").show();
        }else if (item.type === "regreload") {
            $("#container").show();
            $("#reg").show();
            $("#pin").hide();
            $("#video").show();
        }else if (item.type === "loginreload") {
            $("#container").show();
            $("#reg").hide();
            $("#pin").hide();
            $("#video").show();
        }else if (item.type === "end_login") {
            $("#container").hide();
            $("#reg").hide();
            $("#pin").hide();
            $("#video").hide();
        }else if (item.type === "wrong"){
            dots.forEach(function (dot, index) {
                dot.className += ' wrong';
            });
            document.body.className += ' wrong';
        }else if(item.type === "correct"){
            dots.forEach(function (dot, index) {
                dot.className += ' correct';
            });
            document.body.className += ' correct';
        }
        
        return
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`http://sx_accountmanager/exit`, JSON.stringify({}));
        }
    };
    $("#close").click(function () {
        $.post(`http://sx_accountmanager/exit`, JSON.stringify({}));
    })
    $("#registration").click(function () {
        $("#container").hide();
        $("#reg").show();
    })

    $("#log").click(function () {
        $("#container").show();
        $("#reg").hide();
    })
    //when the user clicks on the submit button, it will run
    $("#submitReg").click(function () {
        let username = $('#usernamer').val()
        let password = $('#passwordr').val()
        let passwordconfirm = $('#passwordconfirm').val()
        let email =  $('#email').val()
        let language = $("#langauge :selected").val()
        if (username.length >= 100 && password.length >= 100 
            && username.length <= 3 && password.length <= 3
            && passwordconfirm.length <= 3 && passwordconfirm.length <= 3
            && email.length <= 3 && email.length <= 3) {
            $.post(`https://sx_accountmanager/error`, JSON.stringify({
                error: "To short or to long parameter",
                type: true
            }))
        } else if (!username || !password || !passwordconfirm || !email) {
            $.post(`https://sx_accountmanager/error`, JSON.stringify({
                error: "There was no value in the input field",
                type: true
            }))
        }else if(password != passwordconfirm){
            $.post(`https://sx_accountmanager/error`, JSON.stringify({
                error: "Password don't match",
                type: true
            }))
        }else{
            fetch(`https://sx_accountmanager/register`, {
                method: 'POST',
                headers: {
                 'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                  u: $('#usernamer').val(),
                  p: $('#passwordr').val(),
                  e: $('#email').val(),
                  l: $("#langauge :selected").val()
                })
            }).then(resp => resp.json()).then(resp => console.log(resp));
        }
    })
    
    $("#submit").click(function () {
        let usernamer = $('#username').val()
        let passwordr = $('#password').val()
        if (usernamer.length >= 100 && passwordr.length >= 100 &&  usernamer.length <= 3 && passwordr.length <= 3) {
            $.post(`http://sx_accountmanager/error`, JSON.stringify({
                error: "To short or to long password or username",
                type: false
            }))
        } else if (!usernamer || !passwordr) {
            $.post(`https://sx_accountmanager/error`, JSON.stringify({
                error: "There was no value in the input field",
                type: false
            }))
        }else{

        fetch(`https://sx_accountmanager/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                u: $('#username').val(),
                p: $('#password').val() 
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
        
        }
    })

    var input = '';
    var dots = document.querySelectorAll('.dot'), numbers = document.querySelectorAll('.number');
    dots = Array.prototype.slice.call(dots);
    numbers = Array.prototype.slice.call(numbers);
    numbers.forEach(function (number, index) {
        number.addEventListener('click', function () {
            number.className += ' grow';
            if(index == 9)
            input += 0;
            else
            input += index + 1;

            dots[input.length - 1].className += ' active';
            if (input.length >= 4) {
                fetch(`https://sx_accountmanager/pin`, {
                    method: 'POST',
                    headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                     },
                    body: JSON.stringify({
                        pin: input,
                        d: dots,
                        index: index
                    })
                }).then(resp => resp.json()).then(resp => console.log(resp));
        
                setTimeout(function () {
                    dots.forEach(function (dot, index) {
                        dot.className = 'dot';
                    });
                    input = '';
                }, 900);
                setTimeout(function () {
                    document.body.className = '';
                }, 1000);
            }
            setTimeout(function () {
                number.className = 'number';
            }, 1000);
        });
    });

})

