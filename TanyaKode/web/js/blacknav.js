// header background changing on scroll

const header = document.querySelector('header');
window.onscroll = () => {
  if(this.scrollY <= 10) header.className = 'container'; else header.className = 'container black-bg';
};

