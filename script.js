// cursor follow effect
const dot = document.getElementById('dot');
const ring = document.getElementById('ring');

document.addEventListener('mousemove', e => {
  dot.style.left = e.clientX + 'px';
  dot.style.top = e.clientY + 'px';
  ring.style.left = e.clientX + 'px';
  ring.style.top = e.clientY + 'px';
});

// ring gets bigger on hoverable elements
const hoverables = document.querySelectorAll('a, button, .stat, .skill-box, .proj-card, .ach-item, .cert');
hoverables.forEach(el => {
  el.addEventListener('mouseenter', () => ring.classList.add('big'));
  el.addEventListener('mouseleave', () => ring.classList.remove('big'));
});

// navbar shrinks a little on scroll
window.addEventListener('scroll', () => {
  document.getElementById('nav').classList.toggle('scrolled', window.scrollY > 50);
});

// ---- canvas background (particles + grid) ----
const canvas = document.getElementById('bg');
const ctx = canvas.getContext('2d');
let W, H;

function resize() {
  W = canvas.width = window.innerWidth;
  H = canvas.height = window.innerHeight;
}
resize();
window.addEventListener('resize', resize);

// create particles
const pts = [];
for (let i = 0; i < 110; i++) {
  pts.push({
    x: Math.random() * window.innerWidth,
    y: Math.random() * window.innerHeight,
    vx: (Math.random() - .5) * .28,
    vy: (Math.random() - .5) * .28,
    r: Math.random() * 1.1 + .3,
    a: Math.random() * .45 + .1,
    col: Math.random() > .5 ? '167,139,250' : '96,165,250'
  });
}

function drawGrid() {
  ctx.strokeStyle = 'rgba(167,139,250,0.030)';
  ctx.lineWidth = .5;
  for (let x = 0; x < W; x += 60) {
    ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, H); ctx.stroke();
  }
  for (let y = 0; y < H; y += 60) {
    ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(W, y); ctx.stroke();
  }
}

function loop() {
  ctx.clearRect(0, 0, W, H);
  drawGrid();

  pts.forEach(p => {
    p.x += p.vx;
    p.y += p.vy;
    if (p.x < 0 || p.x > W) p.vx *= -1;
    if (p.y < 0 || p.y > H) p.vy *= -1;

    ctx.beginPath();
    ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
    ctx.fillStyle = `rgba(${p.col},${p.a})`;
    ctx.fill();
  });

  // draw lines between nearby particles
  for (let i = 0; i < pts.length; i++) {
    for (let j = i + 1; j < pts.length; j++) {
      const dx = pts[i].x - pts[j].x;
      const dy = pts[i].y - pts[j].y;
      const d = Math.sqrt(dx * dx + dy * dy);
      if (d < 95) {
        ctx.beginPath();
        ctx.moveTo(pts[i].x, pts[i].y);
        ctx.lineTo(pts[j].x, pts[j].y);
        ctx.strokeStyle = `rgba(167,139,250,${.055 * (1 - d / 95)})`;
        ctx.lineWidth = .5;
        ctx.stroke();
      }
    }
  }

  requestAnimationFrame(loop);
}
loop();

// ---- typewriter effect ----
const words = ['Full-Stack Developer', 'React.js Engineer', 'Node.js Developer', 'Problem Solver'];
let wi = 0, ci = 0, deleting = false;
const typedEl = document.getElementById('typed');

function tick() {
  const w = words[wi];
  if (!deleting) {
    typedEl.textContent = w.slice(0, ++ci);
    if (ci === w.length) {
      deleting = true;
      setTimeout(tick, 1700);
      return;
    }
  } else {
    typedEl.textContent = w.slice(0, --ci);
    if (ci === 0) {
      deleting = false;
      wi = (wi + 1) % words.length;
    }
  }
  setTimeout(tick, deleting ? 55 : 85);
}
setTimeout(tick, 1100);

// ---- scroll reveal ----
const revEls = document.querySelectorAll('.rv');
const obs = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('show');
  });
}, { threshold: .1, rootMargin: '0px 0px -40px 0px' });

revEls.forEach(e => obs.observe(e));
