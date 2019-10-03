const { query } = require('../../lib/mysql');

exports.getAllItems = async ctx => {
    // const mockItems = [
    //     {
    //         id: 0,
    //         title: '뼈다귀 모양 베개',
    //         description: '우리 귀여운 강아지에게 꿀잠을!!',
    //         price: 10000,
    //         image:
    //             'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg',
    //         detailContents: `[\"아이에게 꿀잠을 선사할 수 있는 베개입니다.\",
    //         \"뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.\",
    //         \"가나다라 마바사 아자차카 타파하\",
    //         \"\",
    //         \"테스트 라인 입니다\",
    //         \"테스트 라인 입니다\",
    //         \"테스트 라인 입니다\",
    //         \"테스트 라인 입니다\",
    //         \"테스트 라인 입니다\"]`,
    //         createAt: '',
    //         updateAt: '',
    //     },
    // ];
    try {
        const items = await query('SELECT * FROM ITEM');

        ctx.status = 200;
        ctx.body = {
            message: '',
            items,
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
        ctx.body = {
            message: 'error',
        };
    }
};

// Image.network(
//     'https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'),
// '귀여운 강아지 신발',
// '소중한 아기의 발바닥을 보호합시다',
// 12000,
// <String>[
//   '['아이에게 꿀잠을 선사할 수 있는 베개입니다.',
//   '뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.',
//   '가나다라 마바사 아자차카 타파하',
//   '',
//   '테스트 라인 입니다',
//   '테스트 라인 입니다',
//   '테스트 라인 입니다',
//   '테스트 라인 입니다',
//   '테스트 라인 입니다']'
// ],

exports.searchItems = async ctx => {
    try {
        ctx.status = 200;
        ctx.body = {
            success: true,
        };
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};
