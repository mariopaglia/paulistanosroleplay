window.addEventListener("DOMContentLoaded", () => {

  const emojiContainer = document.querySelector('.emoji-container'),
  emojiOutput = document.querySelectorAll('.emoji-output'),
  dialogBox = document.querySelector('.dialog-box'),
  dialogMessage = document.querySelector('.dialog-message'),
  bellSound1 = document.querySelector('.bell-sound-1'),
  bellSound2 = document.querySelector('.bell-sound-2'),
  bellSound3 = document.querySelector('.bell-sound-3'),
  winSound = document.querySelector('.win-sound'),
  loseSound = document.querySelector('.lose-sound'),
  random = Math.floor(Math.random() * 100),
  outputEmojis = a => emojiOutput.forEach((emoji, i) => emoji.textContent = a[i]),
  shuffleArray = a => {
    for (let i = a.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }

    return a;
  },
    init = () => {
    if (random >= 90) {
      winner = true;
    } else {
      winner = false;
    }
    if (winner) {
      emojis.push('🐦');
      message = "Você Ganhou!";
    } else {
      emojis.push('⌚');
      message = "Você Perdeu!";
    }

    outputEmojis(shuffleArray(emojis));
  },
  rainMoney = () => {
    const w = window.innerWidth;

    //Create dollar bills
    for (i = 0; i < 70; i++) {
      const dollar = document.createElement('div');

      dollar.classList.add('dollar-bill');
      dollar.textContent = '💵';
      dollar.style.left = `${Math.floor(Math.random() * w)}px`;

      document.body.appendChild(dollar);
    }
  };

  let emojis = ['👜', '🏆', '🍾', '🎁', '👑', '💍', '🐦', '🐦'],
  winningEmojisFound = 0,
  emojisRemaining = 9,
  message = '';

  emojiContainer.addEventListener('click', e => {

    const target = e.target;

    if (target.classList.contains('emoji-btn') && !target.classList.contains('uncovered')) {

      emojisRemaining--;

      target.classList.add('uncovered');

      //Check if winning emoji found
      if (target.textContent === '🐦') {

        target.classList.add('winning-emoji');

        //Play winning emoji found sound effect
        switch (winningEmojisFound) {
          case 0:
            bellSound1.play();
            break;
          case 1:
            bellSound2.play();
            break;
          case 2:
            bellSound3.play();
            break;}


        winningEmojisFound++;
      }

      //Check if all emojis revealed
      if (emojisRemaining === 0) {

        //Play sound effect
        setTimeout(() => {
          if (winner) {
            winSound.play();
            setTimeout(() => rainMoney(), 1200);
            $.post('http://Shaw-Lottery/win', JSON.stringify({}));2
          } else {
            loseSound.play();
          }
        }, 1500);

        //Show dialog box
        dialogBox.classList.add('show-dialog');
        dialogMessage.textContent = message;
      }
    }
  });

  //Initialize game
  init();

});