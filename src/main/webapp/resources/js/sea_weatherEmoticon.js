function weatherEmoticon(sky, pty, hour, month, w, h) {
    let imgSrc, title;
    const width = w; // 기본 너비
    const height = h; // 기본 높이

    if (pty === 0 && 6 <= hour && hour <= 18) {
        switch (sky) {
            case 1:
            	if(3 <= month <= 5){
            		imgSrc = "./resources/image/날씨_맑음_봄.gif";
            	}else{
            		imgSrc = "./resources/image/날씨_맑음_기본.gif";
            	}
                title = "날씨 맑음";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_구름_낮.gif";
                title = "구름 많음";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_흐림.gif";
                title = "날씨 흐림";
                break;
            default:
                alert('날씨 값이 들어오지 않았습니다.');
                break;
        }
    } else if (pty !== 0) {
        switch (pty) {
            case 1:
                imgSrc = "./resources/image/날씨_비.gif";
                title = "날씨 비";
                break;
            case 2:
                imgSrc = "./resources/image/날씨_비와눈.png";
                title = "날씨 비와 눈";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_눈.gif";
                title = "날씨 눈";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_소나기.gif";
                title = "날씨 소나기";
                break;
            case 5:
                imgSrc = "./resources/image/날씨_빗방울.gif";
                title = "날씨 빗방울";
                break;
            case 6:
                imgSrc = "./resources/image/날씨_빗방울눈날림.png";
                title = "날씨 빗방울눈날림";
                break;
            case 7:
                imgSrc = "./resources/image/날씨_눈날림.png";
                title = "날씨 눈날림";
                break;
            default:
                break;
        }
    } else if (pty === 0 && 6 > hour || hour > 18) {
        switch (sky) {
            case 1:
                imgSrc = "./resources/image/날씨_맑음_밤.gif";
                title = "밤 날씨 맑음";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_구름_밤.gif";
                title = "밤 구름 많음";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_흐림.gif";
                title = "밤 흐림";
                break;
            default:
                alert('날씨 값이 들어오지 않았습니다.');
                break;
        }
    }

    console.log('타이틀: ' + title);
    return '<img src="' + imgSrc + '" alt="' + title + '"title="' + title + '" width="' + width + '" height="'+ height + '"/>'
}