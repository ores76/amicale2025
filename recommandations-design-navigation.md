# Recommandations Détaillées pour le Design et la Navigation

## Guide de Style et Design System

### 1. Palette de Couleurs Détaillée

#### Couleurs Primaires
```css
/* Bleu Pasteur - Couleur principale */
:root {
  --color-primary: #1e40af;
  --color-primary-light: #3b82f6;
  --color-primary-dark: #1e3a8a;
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-200: #bfdbfe;
  --color-primary-300: #93c5fd;
  --color-primary-400: #60a5fa;
  --color-primary-500: #3b82f6;
  --color-primary-600: #2563eb;
  --color-primary-700: #1d4ed8;
  --color-primary-800: #1e40af;
  --color-primary-900: #1e3a8a;
}

/* Neutres */
:root {
  --color-gray-50: #f9fafb;
  --color-gray-100: #f3f4f6;
  --color-gray-200: #e5e7eb;
  --color-gray-300: #d1d5db;
  --color-gray-400: #9ca3af;
  --color-gray-500: #6b7280;
  --color-gray-600: #4b5563;
  --color-gray-700: #374151;
  --color-gray-800: #1f2937;
  --color-gray-900: #111827;
}

/* Couleurs d'accent */
:root {
  --color-accent-gold: #d97706;
  --color-accent-green: #059669;
  --color-accent-red: #dc2626;
  --color-white: #ffffff;
  --color-black: #000000;
}
```

### 2. Typographie Complète

#### Font Faces
```css
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=Inter:wght@300;400;500;600;700&display=swap');

:root {
  --font-serif: 'Playfair Display', serif;
  --font-sans: 'Inter', sans-serif;
}
```

#### Échelle Typographique
```css
/* Headings */
h1 {
  font-family: var(--font-serif);
  font-size: 2.5rem; /* 40px */
  font-weight: 700;
  line-height: 1.2;
  color: var(--color-gray-900);
}

h2 {
  font-family: var(--font-serif);
  font-size: 2rem; /* 32px */
  font-weight: 700;
  line-height: 1.3;
  color: var(--color-gray-800);
}

h3 {
  font-family: var(--font-serif);
  font-size: 1.5rem; /* 24px */
  font-weight: 600;
  line-height: 1.4;
  color: var(--color-gray-700);
}

h4 {
  font-family: var(--font-serif);
  font-size: 1.25rem; /* 20px */
  font-weight: 600;
  line-height: 1.4;
  color: var(--color-gray-700);
}

/* Body Text */
.body-large {
  font-family: var(--font-sans);
  font-size: 1.125rem; /* 18px */
  font-weight: 400;
  line-height: 1.6;
  color: var(--color-gray-700);
}

.body-base {
  font-family: var(--font-sans);
  font-size: 1rem; /* 16px */
  font-weight: 400;
  line-height: 1.6;
  color: var(--color-gray-600);
}

.body-small {
  font-family: var(--font-sans);
  font-size: 0.875rem; /* 14px */
  font-weight: 400;
  line-height: 1.5;
  color: var(--color-gray-500);
}

/* Special Text */
.quote {
  font-family: var(--font-serif);
  font-size: 1.25rem; /* 20px */
  font-weight: 400;
  font-style: italic;
  line-height: 1.6;
  color: var(--color-gray-700);
}

.caption {
  font-family: var(--font-sans);
  font-size: 0.875rem; /* 14px */
  font-weight: 400;
  line-height: 1.4;
  color: var(--color-gray-500);
}
```

### 3. Système d'Espacement

#### Échelle d'Espacement
```css
:root {
  --space-xs: 0.25rem;  /* 4px */
  --space-sm: 0.5rem;   /* 8px */
  --space-md: 1rem;     /* 16px */
  --space-lg: 1.5rem;   /* 24px */
  --space-xl: 2rem;     /* 32px */
  --space-2xl: 3rem;    /* 48px */
  --space-3xl: 4rem;    /* 64px */
  --space-4xl: 6rem;    /* 96px */
  --space-5xl: 8rem;    /* 128px */
}
```

## Composants de Navigation

### 1. Header Principal

#### Structure HTML
```html
<header class="header">
  <div class="header-container">
    <!-- Logo -->
    <div class="header-logo">
      <a href="/" class="logo-link">
        <img src="/logo.svg" alt="Magazine Pasteur Amicale" class="logo-image">
        <span class="logo-text">Pasteur Amicale</span>
      </a>
    </div>

    <!-- Navigation Desktop -->
    <nav class="nav-desktop">
      <ul class="nav-list">
        <li class="nav-item">
          <a href="/" class="nav-link active">Accueil</a>
        </li>
        <li class="nav-item">
          <a href="/magazine" class="nav-link">Magazine</a>
        </li>
        <li class="nav-item">
          <a href="/actualites" class="nav-link">Actualités</a>
        </li>
        <li class="nav-item">
          <a href="/evenements" class="nav-link">Événements</a>
        </li>
        <li class="nav-item">
          <a href="/association" class="nav-link">Association</a>
        </li>
      </ul>
    </nav>

    <!-- Actions Header -->
    <div class="header-actions">
      <button class="search-button" aria-label="Rechercher">
        <svg class="icon-search" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="11" cy="11" r="8"></circle>
          <path d="m21 21-4.35-4.35"></path>
        </svg>
      </button>
      <a href="/anciens-eleves" class="nav-link">Anciens Élèves</a>
      <a href="/espace-membre" class="btn btn-primary">Espace Membre</a>
      
      <!-- Menu Mobile -->
      <button class="menu-toggle" aria-label="Menu">
        <span class="menu-line"></span>
        <span class="menu-line"></span>
        <span class="menu-line"></span>
      </button>
    </div>
  </div>

  <!-- Navigation Mobile -->
  <nav class="nav-mobile" id="navMobile">
    <ul class="nav-mobile-list">
      <li class="nav-mobile-item">
        <a href="/" class="nav-mobile-link">Accueil</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/magazine" class="nav-mobile-link">Magazine</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/actualites" class="nav-mobile-link">Actualités</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/evenements" class="nav-mobile-link">Événements</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/association" class="nav-mobile-link">Association</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/anciens-eleves" class="nav-mobile-link">Anciens Élèves</a>
      </li>
      <li class="nav-mobile-item">
        <a href="/espace-membre" class="nav-mobile-link">Espace Membre</a>
      </li>
    </ul>
  </nav>
</header>
```

#### Styles CSS
```css
/* Header Styles */
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: var(--color-white);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  z-index: 1000;
}

.header-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-md);
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 70px;
}

/* Logo */
.header-logo {
  display: flex;
  align-items: center;
}

.logo-link {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: var(--color-primary);
}

.logo-image {
  width: 40px;
  height: 40px;
  margin-right: var(--space-sm);
}

.logo-text {
  font-family: var(--font-serif);
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--color-primary);
}

/* Navigation Desktop */
.nav-desktop {
  display: none;
}

@media (min-width: 1024px) {
  .nav-desktop {
    display: block;
  }
}

.nav-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: var(--space-lg);
}

.nav-link {
  text-decoration: none;
  color: var(--color-gray-600);
  font-family: var(--font-sans);
  font-size: 1rem;
  font-weight: 500;
  padding: var(--space-sm) 0;
  border-bottom: 2px solid transparent;
  transition: all 0.3s ease;
}

.nav-link:hover,
.nav-link.active {
  color: var(--color-primary);
  border-bottom-color: var(--color-primary);
}

/* Header Actions */
.header-actions {
  display: flex;
  align-items: center;
  gap: var(--space-md);
}

.search-button {
  background: none;
  border: none;
  cursor: pointer;
  padding: var(--space-sm);
  border-radius: var(--space-sm);
  transition: background-color 0.3s ease;
}

.search-button:hover {
  background-color: var(--color-gray-100);
}

.icon-search {
  color: var(--color-gray-600);
}

/* Buttons */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-sm) var(--space-lg);
  border-radius: var(--space-sm);
  text-decoration: none;
  font-family: var(--font-sans);
  font-size: 0.875rem;
  font-weight: 500;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background-color: var(--color-primary);
  color: var(--color-white);
}

.btn-primary:hover {
  background-color: var(--color-primary-dark);
}

/* Menu Toggle */
.menu-toggle {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 40px;
  height: 40px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
}

@media (min-width: 1024px) {
  .menu-toggle {
    display: none;
  }
}

.menu-line {
  width: 24px;
  height: 2px;
  background-color: var(--color-gray-600);
  margin: 2px 0;
  transition: all 0.3s ease;
}

/* Navigation Mobile */
.nav-mobile {
  position: fixed;
  top: 70px;
  left: 0;
  right: 0;
  background: var(--color-white);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transform: translateY(-100%);
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

.nav-mobile.active {
  transform: translateY(0);
  opacity: 1;
  visibility: visible;
}

.nav-mobile-list {
  list-style: none;
  margin: 0;
  padding: var(--space-lg) 0;
}

.nav-mobile-item {
  border-bottom: 1px solid var(--color-gray-200);
}

.nav-mobile-link {
  display: block;
  padding: var(--space-md) var(--space-lg);
  text-decoration: none;
  color: var(--color-gray-600);
  font-family: var(--font-sans);
  font-size: 1rem;
  font-weight: 500;
  transition: color 0.3s ease;
}

.nav-mobile-link:hover {
  color: var(--color-primary);
}
```

### 2. Footer

#### Structure HTML
```html
<footer class="footer">
  <div class="footer-container">
    <div class="footer-grid">
      <!-- À Propos -->
      <div class="footer-section">
        <h3 class="footer-title">À Propos</h3>
        <p class="footer-text">
          Le Magazine Pasteur Amicale est la voix de notre communauté, 
          reliant les générations d'élèves et célébrant notre héritage commun.
        </p>
        <div class="footer-social">
          <a href="#" class="social-link" aria-label="Facebook">
            <svg class="social-icon" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
            </svg>
          </a>
          <a href="#" class="social-link" aria-label="Twitter">
            <svg class="social-icon" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
            </svg>
          </a>
          <a href="#" class="social-link" aria-label="LinkedIn">
            <svg class="social-icon" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
            </svg>
          </a>
        </div>
      </div>

      <!-- Liens Rapides -->
      <div class="footer-section">
        <h3 class="footer-title">Liens Rapides</h3>
        <ul class="footer-links">
          <li><a href="/magazine" class="footer-link">Magazine</a></li>
          <li><a href="/actualites" class="footer-link">Actualités</a></li>
          <li><a href="/evenements" class="footer-link">Événements</a></li>
          <li><a href="/association" class="footer-link">Association</a></li>
          <li><a href="/anciens-eleves" class="footer-link">Anciens Élèves</a></li>
        </ul>
      </div>

      <!-- Contact -->
      <div class="footer-section">
        <h3 class="footer-title">Contact</h3>
        <ul class="footer-contact">
          <li>
            <svg class="contact-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
              <circle cx="12" cy="10" r="3"></circle>
            </svg>
            <span>123 Rue de l'École, 75000 Paris</span>
          </li>
          <li>
            <svg class="contact-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
            </svg>
            <span>+33 1 23 45 67 89</span>
          </li>
          <li>
            <svg class="contact-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
              <polyline points="22,6 12,13 2,6"></polyline>
            </svg>
            <span>Amicale.IPT@pasteur.tn</span>
          </li>
        </ul>
      </div>

      <!-- Newsletter -->
      <div class="footer-section">
        <h3 class="footer-title">Newsletter</h3>
        <p class="footer-text">
          Inscrivez-vous pour recevoir nos actualités et événements.
        </p>
        <form class="newsletter-form">
          <input type="email" placeholder="Votre email" required>
          <button type="submit" class="btn btn-primary">S'inscrire</button>
        </form>
      </div>
    </div>

    <div class="footer-bottom">
      <p>&copy; 2024 Magazine Pasteur Amicale. Tous droits réservés.</p>
      <div class="footer-bottom-links">
        <a href="/mentions-legales">Mentions Légales</a>
        <a href="/politique-confidentialite">Politique de Confidentialité</a>
        <a href="/cookies">Cookies</a>
      </div>
    </div>
  </div>
</footer>
```

#### Styles CSS Footer
```css
/* Footer Styles */
.footer {
  background-color: var(--color-gray-900);
  color: var(--color-white);
  padding: var(--space-4xl) 0 var(--space-xl);
  margin-top: var(--space-5xl);
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-md);
}

.footer-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--space-2xl);
  margin-bottom: var(--space-2xl);
}

.footer-section h3 {
  font-family: var(--font-serif);
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: var(--space-lg);
  color: var(--color-white);
}

.footer-text {
  font-family: var(--font-sans);
  font-size: 0.875rem;
  line-height: 1.6;
  color: var(--color-gray-300);
  margin-bottom: var(--space-lg);
}

/* Social Links */
.footer-social {
  display: flex;
  gap: var(--space-md);
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  background-color: var(--color-gray-800);
  border-radius: 50%;
  color: var(--color-gray-300);
  text-decoration: none;
  transition: all 0.3s ease;
}

.social-link:hover {
  background-color: var(--color-primary);
  color: var(--color-white);
}

.social-icon {
  width: 20px;
  height: 20px;
}

/* Footer Links */
.footer-links {
  list-style: none;
  margin: 0;
  padding: 0;
}

.footer-links li {
  margin-bottom: var(--space-sm);
}

.footer-link {
  color: var(--color-gray-300);
  text-decoration: none;
  font-family: var(--font-sans);
  font-size: 0.875rem;
  transition: color 0.3s ease;
}

.footer-link:hover {
  color: var(--color-white);
}

/* Footer Contact */
.footer-contact {
  list-style: none;
  margin: 0;
  padding: 0;
}

.footer-contact li {
  display: flex;
  align-items: flex-start;
  margin-bottom: var(--space-md);
  color: var(--color-gray-300);
  font-family: var(--font-sans);
  font-size: 0.875rem;
}

.contact-icon {
  margin-right: var(--space-sm);
  color: var(--color-primary);
  flex-shrink: 0;
  margin-top: 2px;
}

/* Newsletter */
.newsletter-form {
  display: flex;
  flex-direction: column;
  gap: var(--space-sm);
}

.newsletter-form input {
  padding: var(--space-sm);
  border: 1px solid var(--color-gray-700);
  background-color: var(--color-gray-800);
  color: var(--color-white);
  border-radius: var(--space-sm);
  font-family: var(--font-sans);
  font-size: 0.875rem;
}

.newsletter-form input::placeholder {
  color: var(--color-gray-400);
}

.newsletter-form input:focus {
  outline: none;
  border-color: var(--color-primary);
}

/* Footer Bottom */
.footer-bottom {
  border-top: 1px solid var(--color-gray-800);
  padding-top: var(--space-xl);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--space-lg);
}

.footer-bottom p {
  font-family: var(--font-sans);
  font-size: 0.875rem;
  color: var(--color-gray-400);
  margin: 0;
}

.footer-bottom-links {
  display: flex;
  gap: var(--space-lg);
}

.footer-bottom-links a {
  color: var(--color-gray-400);
  text-decoration: none;
  font-family: var(--font-sans);
  font-size: 0.875rem;
  transition: color 0.3s ease;
}

.footer-bottom-links a:hover {
  color: var(--color-white);
}

@media (max-width: 768px) {
  .footer-bottom {
    flex-direction: column;
    text-align: center;
  }
  
  .footer-bottom-links {
    justify-content: center;
    flex-wrap: wrap;
  }
}
```

## 3. Composants de Contenu

### 1. Carte d'Article
```html
<article class="article-card">
  <div class="article-image">
    <img src="/images/article-1.jpg" alt="Description de l'image">
    <div class="article-category">Actualités</div>
  </div>
  <div class="article-content">
    <div class="article-meta">
      <span class="article-date">15 mars 2024</span>
      <span class="article-author">Marie Dupont</span>
    </div>
    <h3 class="article-title">Titre de l'article sur une ou deux lignes maximum</h3>
    <p class="article-excerpt">
      Extrait de l'article qui donne un aperçu du contenu et incite à la lecture...
    </p>
    <a href="/article/1" class="article-link">Lire la suite</a>
  </div>
</article>
```

### 2. Carte d'Événement
```html
<div class="event-card">
  <div class="event-date">
    <span class="event-day">15</span>
    <span class="event-month">MAR</span>
  </div>
  <div class="event-content">
    <h4 class="event-title">Nom de l'événement</h4>
    <div class="event-info">
      <span class="event-time">19h00</span>
      <span class="event-location">Salle des fêtes</span>
    </div>
    <p class="event-description">
      Courte description de l'événement et de son importance...
    </p>
    <button class="btn btn-primary btn-small">S'inscrire</button>
  </div>
</div>
```

### 3. Carte de Magazine
```html
<div class="magazine-card">
  <div class="magazine-cover">
    <img src="/images/magazine-cover.jpg" alt="Couverture du magazine">
    <div class="magazine-issue">Numéro 45 - Mars 2024</div>
  </div>
  <div class="magazine-info">
    <h3 class="magazine-title">Titre du magazine</h3>
    <p class="magazine-description">
      Description du contenu principal de ce numéro...
    </p>
    <div class="magazine-actions">
      <a href="/magazine/45" class="btn btn-primary">Lire en ligne</a>
      <a href="/magazine/45/pdf" class="btn btn-outline">Télécharger PDF</a>
    </div>
  </div>
</div>
```

## 4. Responsive Design

### Breakpoints
```css
/* Mobile */
@media (max-width: 767px) {
  .header-container {
    padding: 0 var(--space-sm);
  }
  
  .footer-grid {
    grid-template-columns: 1fr;
    gap: var(--space-xl);
  }
  
  .article-card {
    flex-direction: column;
  }
}

/* Tablette */
@media (min-width: 768px) and (max-width: 1023px) {
  .header-container {
    padding: 0 var(--space-md);
  }
  
  .footer-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .article-card {
    flex-direction: row;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .header-container {
    padding: 0 var(--space-lg);
  }
  
  .footer-grid {
    grid-template-columns: repeat(4, 1fr);
  }
  
  .article-card {
    flex-direction: row;
  }
}
```

## 5. Animations et Transitions

### Animations CSS
```css
/* Fade In */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in {
  animation: fadeIn 0.6s ease-out;
}

/* Slide In */
@keyframes slideIn {
  from {
    transform: translateX(-100%);
  }
  to {
    transform: translateX(0);
  }
}

.slide-in {
  animation: slideIn 0.3s ease-out;
}

/* Scale */
@keyframes scale {
  from {
    transform: scale(0.9);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

.scale {
  animation: scale 0.4s ease-out;
}

/* Hover Effects */
.article-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.nav-link:hover {
  color: var(--color-primary);
}

/* Loading States */
.skeleton {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}
```

## Conclusion

Ces recommandations de design et de navigation fournissent une base solide pour améliorer l'expérience utilisateur sur mag.pasteuramicale.com. Le design system cohérent, les composants modulaires et l'approche responsive garantiront une expérience optimale sur tous les appareils.

L'implémentation de ces recommandations permettra de créer un site web moderne, professionnel et engageant qui servira efficacement la communauté de l'association Pasteur Amicale.