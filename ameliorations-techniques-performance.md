# Améliorations Techniques et Performance pour mag.pasteuramicale.com

## Introduction

Ce document présente les recommandations techniques et d'optimisation de performance pour garantir que mag.pasteuramicale.com offre une expérience utilisateur rapide, fiable et sécurisée. Les améliorations couvrent l'infrastructure, le code, la base de données et les meilleures pratiques de développement.

## 1. Architecture Technique Recommandée

### 1.1 Stack Technologique

#### Frontend
```json
{
  "framework": "Next.js 15",
  "language": "TypeScript",
  "styling": "Tailwind CSS + Shadcn/ui",
  "stateManagement": "Zustand + TanStack Query",
  "formHandling": "React Hook Form + Zod",
  "animations": "Framer Motion",
  "testing": "Jest + Testing Library"
}
```

#### Backend
```json
{
  "runtime": "Node.js + TypeScript",
  "framework": "Express.js / Next.js API Routes",
  "database": "PostgreSQL + Prisma ORM",
  "authentication": "NextAuth.js",
  "fileStorage": "AWS S3 / Cloudinary",
  "email": "Resend / SendGrid",
  "caching": "Redis + Next.js Cache",
  "monitoring": "Sentry + Vercel Analytics"
}
```

#### Infrastructure
```json
{
  "hosting": "Vercel (Frontend)",
  "backend": "Vercel Functions / AWS Lambda",
  "database": "Supabase / PlanetScale",
  "cdn": "Vercel CDN / Cloudflare",
  "storage": "AWS S3 + CloudFront",
  "dns": "Cloudflare",
  "ssl": "Let's Encrypt (automatique)"
}
```

### 1.2 Structure du Projet

```
mag-pasteuramicale/
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── (auth)/           # Routes d'authentification
│   │   ├── api/              # API Routes
│   │   ├── dashboard/        # Espace membre
│   │   ├── magazine/         # Section magazine
│   │   ├── actualites/       # Actualités
│   │   ├── evenements/       # Événements
│   │   ├── association/      # Association
│   │   ├── anciens-eleves/   # Anciens élèves
│   │   └── globals.css       # Styles globaux
│   ├── components/           # Composants React
│   │   ├── ui/              # Composants UI de base
│   │   ├── forms/           # Formulaires
│   │   ├── layout/          # Composants de layout
│   │   ├── features/        # Composants fonctionnels
│   │   └── common/          # Composants communs
│   ├── lib/                 # Bibliothèques utilitaires
│   │   ├── auth/            # Configuration auth
│   │   ├── db/              # Base de données
│   │   ├── utils/           # Fonctions utilitaires
│   │   ├── validations/     # Schémas de validation
│   │   └── constants/       # Constantes
│   ├── hooks/               # Custom hooks React
│   ├── types/               # Types TypeScript
│   ├── styles/              # Styles spécifiques
│   └── store/               # État global (Zustand)
├── prisma/                  # Schéma de base de données
├── public/                  # Assets statiques
├── docs/                    # Documentation
├── scripts/                 # Scripts de build/déploiement
├── tests/                   # Tests
├── .env.local               # Variables d'environnement
├── .eslintrc.json          # Configuration ESLint
├── tailwind.config.ts      # Configuration Tailwind
├── tsconfig.json           # Configuration TypeScript
└── package.json            # Dépendances du projet
```

## 2. Optimisation de Performance

### 2.1 Next.js Performance Optimizations

#### Configuration Next.js
```typescript
// next.config.ts
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  // Optimisation des images
  images: {
    domains: ['example.com', 'cloudinary.com'],
    formats: ['image/webp', 'image/avif'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
  },
  
  // Compression
  compress: true,
  
  // Headers de sécurité
  headers: async () => [
    {
      source: '/(.*)',
      headers: [
        {
          key: 'X-Frame-Options',
          value: 'DENY',
        },
        {
          key: 'X-Content-Type-Options',
          value: 'nosniff',
        },
        {
          key: 'Referrer-Policy',
          value: 'origin-when-cross-origin',
        },
      ],
    },
  ],
  
  // Réécritures d'API
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: `${process.env.API_URL}/api/:path*`,
      },
    ];
  },
  
  // Variables d'environnement exposées
  env: {
    CUSTOM_KEY: process.env.CUSTOM_KEY,
  },
};

export default nextConfig;
```

#### Optimisation des Images
```typescript
// components/optimized-image.tsx
import NextImage from 'next/image';
import { useState } from 'react';

interface OptimizedImageProps {
  src: string;
  alt: string;
  width?: number;
  height?: number;
  priority?: boolean;
  className?: string;
  onLoad?: () => void;
}

export function OptimizedImage({
  src,
  alt,
  width,
  height,
  priority = false,
  className = '',
  onLoad,
}: OptimizedImageProps) {
  const [isLoading, setIsLoading] = useState(true);

  return (
    <div className={`relative overflow-hidden ${className}`}>
      <NextImage
        src={src}
        alt={alt}
        width={width}
        height={height}
        priority={priority}
        quality={85}
        className={`
          duration-700 ease-in-out
          ${isLoading ? 'scale-110 blur-2xl grayscale' : 'scale-100 blur-0 grayscale-0'}
        `}
        onLoadingComplete={() => {
          setIsLoading(false);
          onLoad?.();
        }}
        sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
      />
    </div>
  );
}
```

### 2.2 Optimisation du Code

#### Code Splitting
```typescript
// components/lazy-component.tsx
import dynamic from 'next/dynamic';

// Chargement paresseux des composants lourds
const HeavyComponent = dynamic(() => import('./heavy-component'), {
  loading: () => <div>Chargement...</div>,
  ssr: false, // Désactiver SSR pour les composants client-only
});

// Chargement paresseux avec suspense
const CalendarComponent = dynamic(() => import('./calendar'), {
  loading: () => <div>Chargement du calendrier...</div>,
  ssr: false,
});
```

#### Optimisation des Imports
```typescript
// Bonne pratique : importer uniquement ce dont on a besoin
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

// Éviter les imports globaux
// ❌ Mauvais : import * as UI from '@/components/ui';
// ✅ Bon : importer spécifiquement chaque composant
```

#### Optimisation des Hooks
```typescript
// hooks/use-optimized-search.ts
import { useState, useEffect, useMemo, useCallback } from 'react';
import { debounce } from 'lodash';

export function useOptimizedSearch<T>(
  items: T[],
  searchFn: (item: T, query: string) => boolean,
  debounceMs = 300
) {
  const [query, setQuery] = useState('');
  const [isSearching, setIsSearching] = useState(false);

  // Fonction de recherche optimisée
  const debouncedSearch = useMemo(
    () => debounce((searchQuery: string) => {
      setIsSearching(true);
      setTimeout(() => setIsSearching(false), 100); // Simuler le délai
    }, debounceMs),
    [debounceMs]
  );

  const filteredItems = useMemo(() => {
    if (!query.trim()) return items;
    return items.filter(item => searchFn(item, query));
  }, [items, query, searchFn]);

  const handleSearchChange = useCallback((value: string) => {
    setQuery(value);
    debouncedSearch(value);
  }, [debouncedSearch]);

  useEffect(() => {
    return () => {
      debouncedSearch.cancel();
    };
  }, [debouncedSearch]);

  return {
    query,
    filteredItems,
    isSearching,
    handleSearchChange,
  };
}
```

### 2.3 Optimisation de la Base de Données

#### Schéma Prisma Optimisé
```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// Indexation optimisée
model User {
  id        String   @id @default(cuid())
  email     String   @unique
  firstName String
  lastName  String
  avatar    String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  // Index pour les recherches fréquentes
  @@index([firstName, lastName])
  @@index([createdAt])
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String
  authorId  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  published Boolean  @default(false)

  author User @relation(fields: [authorId], references: [id])

  // Index pour les performances de requête
  @@index([authorId])
  @@index([createdAt])
  @@index([published])
  @@index([published, createdAt])
}

model Event {
  id          String   @id @default(cuid())
  title       String
  description String
  startDate   DateTime
  endDate     DateTime
  location    String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  // Index pour les requêtes de calendrier
  @@index([startDate])
  @@index([endDate])
  @@index([startDate, endDate])
}
```

#### Requêtes Optimisées
```typescript
// lib/db/queries.ts
import { prisma } from './client';

// Requête optimisée pour la liste d'articles
export async function getPostsPaginated(
  page: number = 1,
  limit: number = 10,
  publishedOnly: boolean = true
) {
  const skip = (page - 1) * limit;

  const [posts, total] = await Promise.all([
    prisma.post.findMany({
      where: publishedOnly ? { published: true } : {},
      include: {
        author: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            avatar: true,
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
      skip,
      take: limit,
    }),
    prisma.post.count({
      where: publishedOnly ? { published: true } : {},
    }),
  ]);

  return {
    posts,
    pagination: {
      page,
      limit,
      total,
      pages: Math.ceil(total / limit),
    },
  };
}

// Requête optimisée pour la recherche
export async function searchPosts(query: string) {
  return prisma.post.findMany({
    where: {
      AND: [
        { published: true },
        {
          OR: [
            {
              title: {
                contains: query,
                mode: 'insensitive',
              },
            },
            {
              content: {
                contains: query,
                mode: 'insensitive',
              },
            },
          ],
        },
      ],
    },
    include: {
      author: {
        select: {
          id: true,
          firstName: true,
          lastName: true,
          avatar: true,
        },
      },
    },
    orderBy: {
      createdAt: 'desc',
    },
    take: 20, // Limiter les résultats pour la performance
  });
}
```

### 2.4 Caching Stratégique

#### Cache API avec Redis
```typescript
// lib/cache/redis.ts
import { createClient } from 'redis';

const redisClient = createClient({
  url: process.env.REDIS_URL,
});

redisClient.on('error', (err) => console.log('Redis Client Error', err));

await redisClient.connect();

export class CacheService {
  private static instance: CacheService;
  private client: typeof redisClient;

  private constructor() {
    this.client = redisClient;
  }

  static getInstance(): CacheService {
    if (!CacheService.instance) {
      CacheService.instance = new CacheService();
    }
    return CacheService.instance;
  }

  async get<T>(key: string): Promise<T | null> {
    try {
      const value = await this.client.get(key);
      return value ? JSON.parse(value) : null;
    } catch (error) {
      console.error('Cache get error:', error);
      return null;
    }
  }

  async set<T>(key: string, value: T, ttl: number = 3600): Promise<void> {
    try {
      await this.client.setEx(key, ttl, JSON.stringify(value));
    } catch (error) {
      console.error('Cache set error:', error);
    }
  }

  async del(key: string): Promise<void> {
    try {
      await this.client.del(key);
    } catch (error) {
      console.error('Cache delete error:', error);
    }
  }

  async invalidatePattern(pattern: string): Promise<void> {
    try {
      const keys = await this.client.keys(pattern);
      if (keys.length > 0) {
        await this.client.del(keys);
      }
    } catch (error) {
      console.error('Cache invalidate pattern error:', error);
    }
  }
}
```

#### Cache Middleware
```typescript
// middleware/cache.ts
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';
import { CacheService } from '@/lib/cache/redis';

const cacheService = CacheService.getInstance();

export async function cacheMiddleware(
  request: NextRequest,
  ttl: number = 3600
): Promise<NextResponse | null> {
  const cacheKey = `cache:${request.url}`;
  
  // Vérifier le cache
  const cachedResponse = await cacheService.get(cacheKey);
  if (cachedResponse) {
    return NextResponse.json(cachedResponse);
  }

  return null; // Pas de cache, continuer la requête
}

export async function setCache(
  request: NextRequest,
  data: any,
  ttl: number = 3600
): Promise<void> {
  const cacheKey = `cache:${request.url}`;
  await cacheService.set(cacheKey, data, ttl);
}
```

## 3. Sécurité

### 3.1 Configuration de Sécurité

#### Headers de Sécurité
```typescript
// middleware/security.ts
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function securityMiddleware(request: NextRequest): NextResponse {
  const response = NextResponse.next();

  // Headers de sécurité
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('Referrer-Policy', 'origin-when-cross-origin');
  response.headers.set(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:; connect-src 'self' https:;"
  );
  response.headers.set('Permissions-Policy', 'camera=(), microphone=(), geolocation=()');
  response.headers.set('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');

  return response;
}
```

#### Validation des Entrées
```typescript
// lib/validations/schemas.ts
import { z } from 'zod';

// Schéma de validation pour les utilisateurs
export const userSchema = z.object({
  email: z.string().email('Email invalide'),
  firstName: z.string().min(2, 'Le prénom doit contenir au moins 2 caractères'),
  lastName: z.string().min(2, 'Le nom doit contenir au moins 2 caractères'),
  phone: z.string().optional(),
  graduationYear: z.number().min(1900).max(new Date().getFullYear() + 1),
  class: z.string().min(1, 'La classe est requise'),
});

// Schéma de validation pour les articles
export const postSchema = z.object({
  title: z.string().min(5, 'Le titre doit contenir au moins 5 caractères'),
  content: z.string().min(10, 'Le contenu doit contenir au moins 10 caractères'),
  excerpt: z.string().max(200, 'L\'extrait ne doit pas dépasser 200 caractères').optional(),
  published: z.boolean().default(false),
  categoryId: z.string().optional(),
});

// Middleware de validation
export function validateSchema<T>(schema: z.ZodSchema<T>) {
  return (data: unknown): T => {
    const result = schema.safeParse(data);
    if (!result.success) {
      throw new Error(`Validation failed: ${result.error.message}`);
    }
    return result.data;
  };
}
```

### 3.2 Authentification Sécurisée

#### Configuration NextAuth.js
```typescript
// lib/auth/config.ts
import { NextAuthOptions } from 'next-auth';
import { PrismaAdapter } from '@next-auth/prisma-adapter';
import { prisma } from '@/lib/db/client';
import CredentialsProvider from 'next-auth/providers/credentials';
import GoogleProvider from 'next-auth/providers/google';
import { verifyPassword } from '@/lib/auth/password';

export const authOptions: NextAuthOptions = {
  adapter: PrismaAdapter(prisma),
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
    CredentialsProvider({
      name: 'credentials',
      credentials: {
        email: { label: 'Email', type: 'email' },
        password: { label: 'Password', type: 'password' },
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) {
          return null;
        }

        const user = await prisma.user.findUnique({
          where: {
            email: credentials.email,
          },
        });

        if (!user) {
          return null;
        }

        const isValidPassword = await verifyPassword(
          credentials.password,
          user.password
        );

        if (!isValidPassword) {
          return null;
        }

        return {
          id: user.id,
          email: user.email,
          name: `${user.firstName} ${user.lastName}`,
          image: user.avatar,
        };
      },
    }),
  ],
  session: {
    strategy: 'jwt',
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.sub = user.id;
      }
      return token;
    },
    async session({ session, token }) {
      if (token) {
        session.user.id = token.sub;
      }
      return session;
    },
  },
  pages: {
    signIn: '/auth/signin',
    signUp: '/auth/signup',
    error: '/auth/error',
  },
};
```

## 4. Monitoring et Analytics

### 4.1 Configuration Sentry
```typescript
// lib/monitoring/sentry.ts
import * as Sentry from '@sentry/nextjs';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  tracesSampleRate: 1.0,
  debug: process.env.NODE_ENV === 'development',
  environment: process.env.NODE_ENV,
});
```

### 4.2 Analytics Personnalisé
```typescript
// lib/analytics/tracking.ts
export class AnalyticsService {
  static trackEvent(event: string, properties?: Record<string, any>) {
    if (typeof window !== 'undefined') {
      // Google Analytics
      if (typeof gtag !== 'undefined') {
        gtag('event', event, properties);
      }
      
      // Analytics personnalisé
      this.sendToCustomAnalytics(event, properties);
    }
  }

  static trackPageView(path: string) {
    if (typeof window !== 'undefined') {
      // Google Analytics
      if (typeof gtag !== 'undefined') {
        gtag('config', process.env.NEXT_PUBLIC_GA_ID!, {
          page_path: path,
        });
      }
    }
  }

  private static async sendToCustomAnalytics(
    event: string,
    properties?: Record<string, any>
  ) {
    try {
      await fetch('/api/analytics', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          event,
          properties,
          timestamp: new Date().toISOString(),
          url: window.location.href,
          userAgent: navigator.userAgent,
        }),
      });
    } catch (error) {
      console.error('Analytics tracking failed:', error);
    }
  }
}
```

## 5. Déploiement et CI/CD

### 5.1 Configuration GitHub Actions
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run linting
      run: npm run lint
    
    - name: Run tests
      run: npm run test
    
    - name: Build application
      run: npm run build
      env:
        DATABASE_URL: ${{ secrets.DATABASE_URL }}
        NEXTAUTH_URL: ${{ secrets.NEXTAUTH_URL }}
        NEXTAUTH_SECRET: ${{ secrets.NEXTAUTH_SECRET }}

  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Deploy to Vercel
      uses: vercel/action@v1
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
        vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
```

### 5.2 Scripts de Déploiement
```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest",
    "test:watch": "jest --watch",
    "type-check": "tsc --noEmit",
    "db:generate": "prisma generate",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "clean": "rm -rf .next out dist",
    "analyze": "ANALYZE=true npm run build"
  }
}
```

## 6. Performance Monitoring

### 6.1 Web Vitals Monitoring
```typescript
// components/web-vitals.tsx
'use client';

import { useReportWebVitals } from 'next/web-vitals';

export function WebVitals() {
  useReportWebVitals((metric) => {
    // Envoyer les métriques à Analytics
    if (metric.value > metric.threshold) {
      console.warn(`Performance warning: ${metric.name} = ${metric.value}`);
    }
    
    // Envoyer à un service de monitoring
    fetch('/api/vitals', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(metric),
    }).catch(console.error);
  });

  return null;
}
```

### 6.2 Performance Budget
```typescript
// next.config.ts
const nextConfig: NextConfig = {
  // ... autres configurations
  
  experimental: {
    // Budget de performance
    optimizePackageImports: ['lucide-react', 'framer-motion'],
  },
  
  // Configuration webpack pour le budget
  webpack: (config, { dev, isServer }) => {
    if (!dev && !isServer) {
      Object.assign(config, {
        performance: {
          hints: 'warning',
          maxEntrypointSize: 512000, // 512KB
          maxAssetSize: 512000, // 512KB
        },
      });
    }
    return config;
  },
};
```

## 7. SEO Optimisé

### 7.1 Metadata Dynamique
```typescript
// app/layout.tsx
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: {
    default: 'Magazine Pasteur Amicale',
    template: '%s | Magazine Pasteur Amicale',
  },
  description: 'Le magazine de la communauté Pasteur Amicale, reliant les générations d\'élèves et célébrant notre héritage commun.',
  keywords: ['Pasteur Amicale', 'magazine', 'école', 'anciens élèves', 'association'],
  authors: [{ name: 'Pasteur Amicale' }],
  creator: 'Pasteur Amicale',
  publisher: 'Pasteur Amicale',
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  metadataBase: new URL('https://mag.pasteuramicale.com'),
  openGraph: {
    title: 'Magazine Pasteur Amicale',
    description: 'Le magazine de la communauté Pasteur Amicale',
    url: 'https://mag.pasteuramicale.com',
    siteName: 'Magazine Pasteur Amicale',
    images: [
      {
        url: '/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'Magazine Pasteur Amicale',
      },
    ],
    locale: 'fr_FR',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Magazine Pasteur Amicale',
    description: 'Le magazine de la communauté Pasteur Amicale',
    images: ['/og-image.jpg'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
};
```

### 7.2 Sitemap et Robots.txt
```typescript
// app/sitemap.ts
import { MetadataRoute } from 'next';
import { getPosts } from '@/lib/db/queries';
import { getEvents } from '@/lib/db/queries';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = 'https://mag.pasteuramicale.com';
  
  // Pages statiques
  const staticPages = [
    '',
    '/magazine',
    '/actualites',
    '/evenements',
    '/association',
    '/anciens-eleves',
    '/contact',
  ].map((route) => ({
    url: `${baseUrl}${route}`,
    lastModified: new Date(),
    changeFrequency: 'monthly' as const,
    priority: 0.8,
  }));

  // Pages dynamiques - Articles
  const posts = await getPosts();
  const postPages = posts.map((post) => ({
    url: `${baseUrl}/actualites/${post.slug}`,
    lastModified: post.updatedAt,
    changeFrequency: 'weekly' as const,
    priority: 0.6,
  }));

  // Pages dynamiques - Événements
  const events = await getEvents();
  const eventPages = events.map((event) => ({
    url: `${baseUrl}/evenements/${event.slug}`,
    lastModified: event.updatedAt,
    changeFrequency: 'weekly' as const,
    priority: 0.6,
  }));

  return [...staticPages, ...postPages, ...eventPages];
}

// app/robots.ts
import { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  const baseUrl = 'https://mag.pasteuramicale.com';
  
  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: '/private/',
      disallow: '/api/',
    },
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
```

## 8. Testing Strategy

### 8.1 Configuration Jest
```typescript
// jest.config.ts
import nextJest from 'next/jest.js';

const createJestConfig = nextJest({
  dir: './',
});

const customJestConfig = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  testEnvironment: 'jest-environment-jsdom',
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
  testPathIgnorePatterns: [
    '<rootDir>/.next/',
    '<rootDir>/node_modules/',
  ],
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/app/layout.tsx',
  ],
};

export default createJestConfig(customJestConfig);
```

### 8.2 Exemples de Tests
```typescript
// __tests__/components/button.test.tsx
import { render, screen } from '@testing-library/react';
import { Button } from '@/components/ui/button';

describe('Button', () => {
  it('renders correctly', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    
    const button = screen.getByText('Click me');
    button.click();
    
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('applies variant classes correctly', () => {
    render(<Button variant="destructive">Delete</Button>);
    const button = screen.getByText('Delete');
    expect(button).toHaveClass('bg-destructive');
  });
});
```

## 9. Documentation

### 9.1 Structure de Documentation
```markdown
# Documentation Technique

## Architecture
- [Overview](./architecture/overview.md)
- [Stack Technique](./architecture/tech-stack.md)
- [Structure du Projet](./architecture/project-structure.md)

## Développement
- [Configuration de l'Environnement](./development/setup.md)
- [Conventions de Code](./development/code-conventions.md)
- [Testing](./development/testing.md)
- [Déploiement](./development/deployment.md)

## API
- [Authentication](./api/auth.md)
- [Users API](./api/users.md)
- [Posts API](./api/posts.md)
- [Events API](./api/events.md)

## Base de Données
- [Schéma](./database/schema.md)
- [Migrations](./database/migrations.md)
- [Optimisations](./database/optimizations.md)

## Performance
- [Optimisations Frontend](./performance/frontend.md)
- [Optimisations Backend](./performance/backend.md)
- [Monitoring](./performance/monitoring.md)
```

## Conclusion

Ces améliorations techniques et recommandations de performance fourniront une base solide pour le développement et la maintenance de mag.pasteuramicale.com. En suivant ces meilleures pratiques, le site bénéficiera de :

- **Performance optimale** avec des temps de chargement rapides
- **Sécurité renforcée** pour protéger les données des utilisateurs
- **Scalabilité** pour gérer la croissance du trafic et des fonctionnalités
- **Maintenabilité** avec un code propre et bien documenté
- **Expérience utilisateur** fluide et professionnelle

L'implémentation progressive de ces recommandations garantira que le site reste performant, sécurisé et à jour avec les dernières technologies et meilleures pratiques du web.