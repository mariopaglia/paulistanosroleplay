const $faces = document.querySelectorAll('.face');
const $cub = document.querySelector('.cub');
const $btnNext = document.querySelector('.instagram-stories__btn-next');
const $btnPrev = document.querySelector('.instagram-stories__btn-prev');

let faceIndex = 0;
let storieIndex = 0;
let imgIndex = 0;
let imgInterval = 0;
let imgProgress = 0;
let countRotation = 1;
let crrRotationDeg = 0;
const stories = [{
        user: {
            name: 'Nome do Usuario',
            imageURL: 'https://www.rockstargames.com/br/img/global/downloads/buddyiconsconavatars/v_afterhours_taleofus2_256x256.jpg',
        },
        images: [
            'https://cdn.dooca.store/180/files/gta-v-hd.jpg',
        ],
    },

];

const createElement = (tagName, props) => {
    const element = document.createElement(tagName);

    Object
        .entries(props)
        .forEach(([key, value]) => element.setAttribute(key, value));

    return element;
};

const rotateCub = (rotation) => {
    $cub.style.transform = `rotateY(-${rotation}deg)`;
};

const renderInFace = (index, element) => {
    $(".stories-opened").css({ "display": "block" });
    $(".stories-opened").animate({
        left: 0 + "vh"
    }, 200);

    $faces[index].innerHTML = '';
    $faces[index].append(element);
};

const nextFace = () => {
    if (stories[storieIndex].images[imgIndex + 1]) {
        imgIndex++;
        imgProgress = 0;
        return;
    } else if (!stories[storieIndex + 1]) {
        return;
    }

    storieIndex++;
    countRotation++;
    crrRotationDeg += 90
    faceIndex = ((countRotation % 4) || 4) - 1;

    if (!stories[storieIndex]) {
        storieIndex = 0;
    }

    renderInFace(faceIndex, createStorie(stories[storieIndex]));
    rotateCub(crrRotationDeg);
};

const prevFace = () => {
    if (stories[storieIndex].images[imgIndex - 1]) {
        imgIndex--;
        imgProgress = 0;
        return;
    }

    if (crrRotationDeg <= 0) return;

    storieIndex--;
    countRotation--;
    crrRotationDeg -= 90;
    faceIndex = ((countRotation % 4) || 4) - 1;

    renderInFace(faceIndex, createStorie(stories[storieIndex]));
    rotateCub(crrRotationDeg);
};

const closeStorie = () => {
    $(".stories-opened").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".stories-opened").css({ "display": "none" });
    });

    // $(".stories-opened").css({ "display": "block" });
};

const createStorie = (storieData) => {
        imgIndex = 0;
        imgProgress = 0;

        const rootElement = createElement('div', {
            class: 'instagram-stories__storie',
        });

        // const renderStorie = () => (
        //   rootElement.innerHTML = `<header class="instagram-storie__header">
        //           <div class="instagram-storie__header__user">
        //             <img
        //               alt="Foto do perfil do usuário"
        //               class="instagram-storie__header__user-image"
        //               src="${storieData.user.imageURL}"
        //             />
        //             <h2 class="instagram-storie__header__user-name">
        //               ${storieData.user.name}
        //             </h2>
        //           </div>
        //           <div class="instagram-storie__header__options">
        //              <i class="fa fa-home" aria-hidden="true"></i>

        //           </div>
        //         </header>
        //         <div class="instagram-storie__progress">
        //           ${storieData.images.map((_, index) =>(
        //             `
        //             <div class="instagram-storie__progress-item">
        //               <div
        //                 class="instagram-storie__progress-item__bar"
        //                 style="width: ${index === imgIndex ? `${imgProgress}%` : (
        //                   index < imgIndex ? '100%' : '0%'
        //                 )}"
        //               >
        //               </div>
        //             </div>
        //           `
        //           )).join('')}
        //         </div>
        //         <div
        //           class="instagram-storie__image"
        //           style="background-image: url('${storieData.images[imgIndex]}')"
        //         >
        //         </div>`
        //   );

        const renderStorie = () => (
                rootElement.innerHTML = `
            <div class="instagram-storie__progress">
              ${storieData.images.map((_, index) =>(
                `
                <div class="instagram-storie__progress-item">
                  <div
                    class="instagram-storie__progress-item__bar"
                    style="width: ${index === imgIndex ? `${imgProgress}%` : (
                      index < imgIndex ? '100%' : '0%'
                    )}"
                  >
                  </div>
                </div>
              `
              )).join('')}
            </div>
            <div
              class="instagram-storie__image"
              style="background-image: url('${storieData.images[imgIndex]}')"
            >
            </div>`
      );

  const startImgProgress = () => {
    clearInterval(imgInterval);

    imgInterval = setInterval(() => {
      imgProgress += 10 / 3;

      if (imgIndex === storieData.images.length) {
        // nextFace()
        return;
      }

      if (imgProgress > 100) {
        closeStorie()
        imgIndex++;
        imgProgress = 0;
        return;
      }

      renderStorie();
    }, 200);
  };

  renderStorie();
  startImgProgress();

  return rootElement;
};

// $btnNext.addEventListener('click', nextFace);
// $btnPrev.addEventListener('click', prevFace);

$cub.style.transformOrigin = `center center ${(-$cub.clientWidth / 2)}px`;
$faces[2].style.transform = `translateZ(-${$faces[2].clientWidth}px) rotateY(180deg) translateX(-100%)`;

window.addEventListener('resize', (event) => {
  $cub.style.transformOrigin = `center center ${(-$cub.clientWidth / 2)}px`;
  $faces[2].style.transform = `translateZ(-${$faces[2].clientWidth}px) rotateY(180deg) translateX(-100%)`;
});

// renderInFace(0, createStorie(stories[storieIndex]));

function chamastorie(){
  renderInFace(0, createStorie(stories[storieIndex]));
}