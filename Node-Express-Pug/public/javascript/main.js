// (function() {
//     function init() {
//         document.querySelector('#register-form-btn').addEventListener('click', registerForm);
//     }
//     function registerForm() {
//         // $.ajax({
//         //     type: "GET",
//         //     url: "localhost:3000/register",
//             // contentType: 'application/json',
//             // data: JSON.stringify(body_id),
//             // success: function(data) {
//             //     let html = '';
//             //     for(let i = 0; i < data.msg.length; i++) {
//             //         html += '<tr>' +
//             //             '<td>' + data.msg[i].id + '</td>' +
//             //             '<td>' + data.msg[i].userName + '</td>' +
//             //             '<td><input type="text" value='+ data.msg[i].passWord +' id="passWord'+data.msg[i].id+'"/></td>' +
//             //             '<td>'+
//             //             '<span style="color:red;" onclick="del(' + data.msg[i].id + ',' + data.login_id + ')">删除</span>'+
//             //             '<span style="color:blue;" onclick="upd(' + data.msg[i].id + ',' + data.login_id + ')">修改</span>'+
//             //             '</td>' +
//             //             '</tr>';
//             //     }
//             //     $("#tbody").html(html);
//             // }
//         // });
//
//         var xhttp = new XMLHttpRequest();
//         xhttp.open("GET", "/register", true);
//         xhttp.send();
//
//     }
//
//     init();
//
// })();