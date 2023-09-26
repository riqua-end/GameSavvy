
console.log("Reply Module...");

let replyService = (function(){
	
	function add(reply,callback,error){
		console.log("add...");
		
		$.ajax({
			type: 'post',
			url: '../replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=UTF-8",
			success: function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr,status,er) {
				if(error) {
					error(er);
				}	
			}
		}); //ajax
	} //add함수
	
	function getList(param, callback, error) {
		
		let bno = param.bno;
		let page = param.page || 1;
		
		$.getJSON("../replies/pages/" + bno + "/" + page,
			function(data) {
				if(callback) {
					callback(data);
				}
			}
		)
		.fail(function(xhr,status,err) {
			if(error) {
				error(err);
			}
		});			
	} //getList()
	
	function remove(rno, replyer, callback, error) {
		
		console.log("------------------------------");
		console.log(JSON.stringify({rno:rno, replyer:replyer}));
		
		$.ajax({
			type:'delete',
			url: '../replies/' + rno,
			data: JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=UTF-8",
			success: function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		}); //ajax
	} //remove()
	
	function update(reply, callback, error) {
		
		console.log("rno: " + reply.rno);
		
		$.ajax({
			type: 'put',
			url: '../replies/' + reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result,status,xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr,status,er) {
				if(error) {
					error(er);
				}
			}
		}); //ajax
	} //update
	
	
	function get(rno,callback, error) {
		
		$.get("../replies/" + rno, function(result) {
			if(callback) {
				callback(result);
			}
		});
	} //get
	
	// 댓글 작성일을 상대적인 시간으로 포맷하는 함수
    function formatDateToRelativeTime(date) {
        // 현재 시간을 가져옴
        let now = new Date();
        // 댓글 작성일을 JavaScript Date 객체로 변환
        let postDate = new Date(date);
        // 현재 시간과 댓글 작성일의 차이를 밀리초 단위로 계산
        let timeDiff = now.getTime() - postDate.getTime();
        // 차이를 초 단위로 계산
        let seconds = Math.floor(timeDiff / 1000);

        // 게시된 지 60초 이내라면 "방금"을 반환
        if (seconds < 60) {
            return "방금";
        }
        // 게시된 지 1시간 이내라면 분 단위로 표시
        else if (seconds < 3600) {
        	let minutes = Math.floor(seconds / 60);
            return minutes + "분 전";
        }
        // 게시된 지 24시간 이내라면 시간 단위로 표시
        else if (seconds < 86400) {
        	let hours = Math.floor(seconds / 3600);
            return hours + "시간 전";
        }
        // 24시간이 지나면 "어제"를 반환
        else {
        	let days = Math.floor(seconds / 86400);
            if (days === 1) {
                return "어제";
            } else {
                // 년, 월, 일을 가져와서 "년-월-일" 형식으로 반환
                let year = postDate.getFullYear();
                let month = String(postDate.getMonth() + 1).padStart(2, '0');
                let day = String(postDate.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }
        }
    }

	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		formatDateToRelativeTime : formatDateToRelativeTime
	};
	
})();