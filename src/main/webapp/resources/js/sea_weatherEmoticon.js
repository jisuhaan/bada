function getWeatherImageAndTitle(sky, pty, hour, month) {
    let imgSrc = "";
    let title = "";

    const isDaytime = (6 <= hour && hour <= 18);
    const isSpring = (3 <= month && month <= 5);

    if (pty === 0) {
        if (isDaytime) {
            switch (sky) {
                case 1:
                    imgSrc = isSpring ? "./resources/image/날씨_맑음_봄.gif" : "./resources/image/날씨_맑음_기본.gif";
                    title = "맑음";
                    break;
                case 3:
                    imgSrc = "./resources/image/날씨_구름_낮.gif";
                    title = "구름많음";
                    break;
                case 4:
                    imgSrc = "./resources/image/날씨_흐림.gif";
                    title = "흐림";
                    break;
                default:
                    alert('날씨 값이 들어오지 않았습니다.');
                    break;
            }
        } else {
            switch (sky) {
                case 1:
                    imgSrc = "./resources/image/날씨_맑음_밤.gif";
                    title = "맑음";
                    break;
                case 3:
                    imgSrc = "./resources/image/날씨_구름_밤.gif";
                    title = "구름많음";
                    break;
                case 4:
                    imgSrc = "./resources/image/날씨_흐림.gif";
                    title = "흐림";
                    break;
                default:
                    alert('날씨 값이 들어오지 않았습니다.');
                    break;
            }
        }
    } else {
        switch (pty) {
            case 1:
                imgSrc = "./resources/image/날씨_비.gif";
                title = "비";
                break;
            case 2:
                imgSrc = "./resources/image/날씨_비와눈.png";
                title = "비와 눈";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_눈.gif";
                title = "눈";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_소나기.gif";
                title = "소나기";
                break;
            case 5:
                imgSrc = "./resources/image/날씨_빗방울.gif";
                title = "빗방울";
                break;
            case 6:
                imgSrc = "./resources/image/날씨_빗방울눈날림.png";
                title = "빗방울·눈날림";
                break;
            case 7:
                imgSrc = "./resources/image/날씨_눈날림.png";
                title = "눈날림";
                break;
            default:
                alert('날씨 값이 들어오지 않았습니다.');
                break;
        }
    }

    return { imgSrc, title };
}

function weatherEmoticon(sky, pty, hour, month, w, h) {
    const { imgSrc, title } = getWeatherImageAndTitle(sky, pty, hour, month);
    console.log('타이틀: ' + title);
    return `<img src="${imgSrc}" alt="${title}" title="${title}" width="${w}" height="${h}"/>`;
}

function weatherEmoticonWithTitle(sky, pty, hour, month, w, h) {
    const { imgSrc, title } = getWeatherImageAndTitle(sky, pty, hour, month);
    console.log('타이틀: ' + title);
    return `<img src="${imgSrc}" alt="${title}" title="${title}" width="${w}" height="${h}"/><span id="today_text">&nbsp;${title}</span>`;
}
