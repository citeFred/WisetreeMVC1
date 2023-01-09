/**
 * 
 */
 
  
(function() {
	// 사용자 정의 정렬 설정하기
    $.extend($.fn.dataTableExt.oSort, {
        "lastname-sort-pre": function (a) {
            return a.split(' ').reverse().join(' ');
        },
        "lastname-sort-asc": function(a, b) { return a < b ? -1 : a > b ? 1 : 0; },
        "lastname-sort-desc": function(a, b) { return a > b ? -1 : a < b ? 1 : 0; },
        "unitnumber-pre": function(a) { return new Number(a.split(' ')[0]); },
        "unitnumber-asc": function(a, b) { return a - b; },
        "unitnumber-desc": function(a, b) { return b - a; }
    } )

	/*
	TODO : 아작스로 데이터 가져오기 샘플
	function fetchData(callback) {
		$.get('/list/')
			.success(callback)
			.error(callback);
		}
	*/

	// 콜백함수로 데이터 가져오기
    var fetchData = function(callback) {
        var data = [
            [1,'서울', 12, 32, 'Walking'],
            [2,'대전',32, 42, 'Bus'],
            [3,'대구',32, 12, 'Cycling'],
            [4,'부산',42, 180, 'Bus'],
            [5,'광주',35, 31, 'Driving'],
            [6,'전주',80,42, 'Driving'],
            [7,'여수',65,43, 'Cycling'],
            [8,'평창',63, 51, 'Bus'],
            [9,'천안',34, 23, 'Walking'],
            [10,'인천',55, 11, 'Walking'],
            [11,'경주',58, 14, 'Walking'],
            [12,'세종',34, 15, 'Cycling'],
            [13,'부여',16, 23, 'Walking'],
            [14,'강릉',43, 35, 'Driving'],
            [15,'포항',23, 13, 'Walking']

        ];
        callback(data);
    };

	// 테이블 초기화
    var table = window.table = $("#table1").dataTable({
        'bLengthChange': false, 'bFilter': false,
		// 페이지당 아이템 갯수
        'iDisplayLength': 7,
		// 사용자 정의 렌더링 함수 설정
        'aoColumnDefs':[
			{
            aTargets: [2,3], // 2,3번열에 설정
            mRender: function(data) { return data + ' 도'; }, // 3번열 데이터 뒤에 'km' 글자를 붙여준다
            sType: 'unitnumber'	// 사용자 정의 정렬 설정 (fn.dataTableExt.oSort)
			}, 
			{
            aTargets: [1],	// 1번열에 설정
            sType: 'lastname-sort'	// 사용자 정의 정렬 설정 (fn.dataTableExt.oSort)
			}
		]
    });

	// 데이터 변경 함수
    var setData = window.tableSetData = function(data) {
        table.fnClearTable();
        table.fnAddData(data);
        table.fnDraw();
    };

	// 초기 데이터 가져오기
    fetchData(function(data) {
        window.tableData = data;
        setData(data);
    });

}());
 