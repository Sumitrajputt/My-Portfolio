$file = 'C:\Users\asus\Desktop\index.html\inde.html'
$content = Get-Content $file -Raw -Encoding UTF8

# ── 1. THEME COLORS → professional deep violet/indigo ──────────────────────
$content = $content.Replace('--bg: #050A0E;', '--bg: #07061A;')
$content = $content.Replace('--bg-card: rgba(13,31,45,0.85);', '--bg-card: rgba(20,15,55,0.88);')
$content = $content.Replace('--accent: #00FFB2;', '--accent: #A78BFA;')
$content = $content.Replace('--accent-blue: #00C8FF;', '--accent-blue: #60A5FA;')
$content = $content.Replace('--border: rgba(0,255,178,0.15);', '--border: rgba(167,139,250,0.18);')
$content = $content.Replace('--glow-green: 0 0 22px rgba(0,255,178,0.28);', '--glow-green: 0 0 28px rgba(167,139,250,0.38);')

# Canvas particle colors
$content = $content.Replace("col: Math.random() > .5 ? '0,255,178' : '0,200,255'", "col: Math.random() > .5 ? '167,139,250' : '96,165,250'")

# Grid line color
$content = $content.Replace("ctx.strokeStyle = 'rgba(0,255,178,0.028)';", "ctx.strokeStyle = 'rgba(167,139,250,0.030)';")

# Particle connection color
$content = $content.Replace('ctx.strokeStyle = `rgba(0,255,178,', 'ctx.strokeStyle = `rgba(167,139,250,')

# accent highlights in CSS rgba usage
$content = $content -replace 'rgba\(0,255,178,', 'rgba(167,139,250,'
$content = $content -replace 'rgba\(0,200,255,', 'rgba(96,165,250,'
$content = $content -replace '#00FFB2', '#A78BFA'
$content = $content -replace '#00C8FF', '#60A5FA'

# ── 2. HERO: name on one straight line ──────────────────────────────────────
$content = $content.Replace(
  '<h1 class="name">
  Sumit<br>
  <span class="outline">Kumar Singh</span>
</h1>',
  '<h1 class="name">Sumit <span class="outline">Kumar Singh</span></h1>'
)

# ── 3. ABOUT ME text replacement ────────────────────────────────────────────
$oldAbout = @'
    <div class="about-text rv">
      <p>I'm a <strong>CSE undergrad at Parul University</strong> (2023&#x2013;2027), building full-stack web apps that actually solve problems &#x2013; not just demo-ware.</p>
      <p>My stack is React, Node, and MongoDB. I like systems that are <strong>clean on the inside</strong> as much as the outside &#x2013; solid API design, proper auth, deployable code.</p>
      <p>I've participated in hackathons, grind DSA on LeetCode, and keep exploring the overlap between <strong>AI/ML and web engineering</strong>. Always building, always learning.</p>
    </div>
'@

# Use a regex-based approach since the content may have encoding differences
$content = $content -replace '(?s)<div class="about-text rv">.*?</div>(?=\s*<div class="stats)', '<div class="about-text rv">
      <p>Hello! I''m <strong>Sumit Rajput</strong>, a passionate Computer Science Engineering student of <strong>Parul University</strong> and future <strong>Full Stack Developer</strong>.</p>
      <p>I enjoy turning ideas into real-world web applications using modern technologies. My interests include <strong>Web Development</strong>, Python Programming, Software Engineering, and Problem Solving.</p>
      <p>Currently, I''m focused on improving my development skills through projects and coding practice.</p>
    </div>'

# ── 4. EDUCATION: add Secondary & Intermediate cards before B.Tech ───────────
$btechCard = '<div class="edu-card rv d1">'

$newEduCards = @'
    <!-- Secondary School -->
    <div class="edu-card rv d1" style="border-left: 3px solid var(--accent);">
      <div class="edu-badge">&#127979; Secondary</div>
      <div class="edu-deg">Secondary School Examination</div>
      <div class="edu-uni">NAV UTTKRAMIT MS SACHULEPUR HUSSAINGANJ (SIWAN)</div>
      <div class="edu-meta">
        <div class="edu-m">
          <span>70.5%</span>
          Grade
        </div>
        <div class="edu-m">
          <span>2021</span>
          BSEB Board
        </div>
      </div>
    </div>

    <!-- Intermediate -->
    <div class="edu-card rv d2" style="border-left: 3px solid var(--accent-blue);">
      <div class="edu-badge">&#127979; Intermediate</div>
      <div class="edu-deg">Intermediate Annual Examination</div>
      <div class="edu-uni">Rajdeo Singh College (Siwan)</div>
      <div class="edu-meta">
        <div class="edu-m">
          <span>68.4%</span>
          Grade
        </div>
        <div class="edu-m">
          <span>2023</span>
          BSEB Board
        </div>
      </div>
    </div>

    <!-- B.Tech -->
    <div class="edu-card rv d1">
'@

$content = $content.Replace($btechCard, $newEduCards)

# Fix edu-wrap to 3 columns now
$content = $content.Replace('.edu-wrap { display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; }',
  '.edu-wrap { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px,1fr)); gap: 2rem; }')

# ── 5. TALENTELY icon after LeetCode ────────────────────────────────────────
$leetcodeEnd = @'
        LeetCode
      </a>
    </div>
'@

$talentely = @'
        LeetCode
      </a>
      <a href="https://lms.talentely.com/in/a4336e59-dc41-4b82-a7ce-feeab5298f6f" target="_blank" class="clink">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="17" height="17">
          <path d="M12 2L2 7l10 5 10-5-10-5zm0 7.236L4.764 5.618 12 2l7.236 3.618L12 9.236zM2 17l10 5 10-5-10-5-10 5zm10 2.764L4.764 17 12 14.764 19.236 17 12 19.764zM2 12l10 5 10-5-10-5-10 5zm10 2.764L4.764 12 12 9.764 19.236 12 12 14.764z"/>
        </svg>
        Talentely
      </a>
    </div>
'@

$content = $content.Replace($leetcodeEnd, $talentely)

# ── 6. Add Education nav link ───────────────────────────────────────────────
# Already has education link, no change needed

# Write back
[System.IO.File]::WriteAllText($file, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "SUCCESS: All portfolio updates applied!"
