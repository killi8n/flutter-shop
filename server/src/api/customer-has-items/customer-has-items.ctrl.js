const { decodeToken } = require('../../lib/token');

exports.create = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

//       _ItemInfo(0, Image.network('http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'    ), '뼈다귀 모양 베개'  , 10000, 1),
//       _ItemInfo(1, Image.network('https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'   ), '빨간 스웨터'       ,  8000, 2),
//       _ItemInfo(2, Image.network('https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'  ), '강아지 용 백팩'    , 18000, 3),
//       _ItemInfo(3, Image.network('https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'), '귀여운 강아지 신발', 12000, 1),
exports.getAll = async ctx => {
    const { authorization: token } = ctx.request.headers;

    try {
        const decoded = await decodeToken(token);
        const { id } = decoded;
        const mockCarts = [
            {
                id: 0,
                customerId: id,
                itemId: 0,
                count: 1,
                status: '',
                paidDtm: '',
                createAt: '',
                updateAt: '',
                item: {
                    id: 0,
                    title: '뼈다귀 모양 베개',
                    description: '우리 귀여운 강아지에게 꿀잠을!!',
                    price: 10000,
                    image:
                        'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg',
                    detailContents: `[\"아이에게 꿀잠을 선사할 수 있는 베개입니다.\",
                    \"뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.\",
                    \"가나다라 마바사 아자차카 타파하\",
                    \"\",
                    \"테스트 라인 입니다\",
                    \"테스트 라인 입니다\",
                    \"테스트 라인 입니다\",
                    \"테스트 라인 입니다\",
                    \"테스트 라인 입니다\"]`,
                    createAt: '',
                    updateAt: '',
                },
            },
        ];
        ctx.body = {
            message: '',
            items: mockCarts,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
        ctx.body = {
            message: 'internal server error',
        };
    }
};

exports.getById = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

exports.updateById = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};

exports.pay = async ctx => {
    try {
        ctx.body = {
            success: true,
        };
        ctx.status = 200;
    } catch (e) {
        console.log(e);
        ctx.status = 500;
    }
};
