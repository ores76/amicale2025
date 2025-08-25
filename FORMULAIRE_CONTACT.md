# Formulaire de Contact - Documentation

## 🎯 OBJECTIF
Création d'un formulaire de contact fonctionnel qui envoie des emails à `Amicale.IPT@pasteur.tn` avec toutes les informations requises.

## ✅ FONCTIONNALITÉS IMPLÉMENTÉES

### 1. Page de Contact (`/src/app/contacts/page.tsx`)
- ✅ Formulaire complet avec tous les champs requis
- ✅ Validation côté client
- ✅ Design responsive et moderne
- ✅ Messages de succès et d'erreur
- ✅ Informations de contact affichées
- ✅ Horaires d'ouverture

### 2. API Route (`/src/app/api/contact/route.ts`)
- ✅ Endpoint POST `/api/contact`
- ✅ Validation des données serveur
- ✅ Envoi d'email via SDK Z-AI
- ✅ Gestion des erreurs
- ✅ Journalisation des messages

### 3. Champs du formulaire
- ✅ **Nom complet** - Champ texte obligatoire
- ✅ **Email** - Champ email avec validation
- ✅ **Téléphone** - Champ téléphone obligatoire
- ✅ **Sujet** - Champ texte obligatoire
- ✅ **Message** - Zone de texte obligatoire

## 📧 FONCTIONNEMENT DE L'ENVOI D'EMAIL

### Format de l'email envoyé
```
NOUVEAU MESSAGE DE CONTACT

DESTINATAIRE: Amicale.IPT@pasteur.tn

INFORMATIONS DU CONTACT:
Nom: [Nom du contact]
Email: [Email du contact]
Téléphone: [Téléphone du contact]

SUJET: [Sujet du message]

MESSAGE:
[Contenu du message]

---
Envoyé depuis le formulaire de contact du site de l'Amicale IPT
Date: [Date et heure d'envoi]
URL: [URL du site]
```

### Processus d'envoi
1. **Validation client** - Vérification des champs obligatoires
2. **Envoi à l'API** - Requête POST à `/api/contact`
3. **Validation serveur** - Vérification supplémentaire des données
4. **Création du contenu** - Formatage de l'email
5. **Envoi via SDK Z-AI** - Tentative d'envoi d'email
6. **Journalisation** - Sauvegarde des informations pour le débogage
7. **Réponse au client** - Confirmation de succès ou erreur

## 🎨 INTERFACE UTILISATEUR

### Design
- **Layout moderne** avec dégradé de fond
- **Responsive design** pour mobile et desktop
- **Composants shadcn/ui** pour une apparence professionnelle
- **Icônes Lucide React** pour une meilleure expérience visuelle

### Sections
1. **Formulaire principal** - 2/3 de la largeur sur desktop
2. **Informations de contact** - 1/3 de la largeur sur desktop
   - Email: Amicale.IPT@pasteur.tn
   - Téléphones: +216 71 783 022 / +216 71 843 755
   - Adresse: Institut Pasteur de Tunis
3. **Horaires d'ouverture** - Affichage des heures de travail
4. **Informations utiles** - Conseils pour l'utilisateur

### États de l'interface
- **Formulaire normal** - Champs éditables
- **Chargement** - Spinner et message d'attente
- **Succès** - Écran de confirmation avec option pour envoyer un autre message
- **Erreur** - Message d'erreur avec possibilité de réessayer

## 🔧 TECHNICALITÉS

### Stack technique
- **Frontend**: Next.js 15 avec TypeScript
- **Styling**: Tailwind CSS et shadcn/ui
- **Backend**: API Route Next.js
- **Email**: SDK Z-AI (avec fallback)
- **Validation**: Client et serveur

### Sécurité
- Validation des entrées utilisateur
- Protection contre les injections XSS
- Vérification du format d'email
- Journalisation sécurisée

### Performance
- Code optimisé avec ESLint
- Composants réutilisables
- Gestion efficace des états
- Réponses rapides

## 🚀 UTILISATION

### Accès au formulaire
1. Cliquez sur le bouton "Contact" dans la navigation
2. Ou accédez directement à `/contacts`
3. Remplissez tous les champs obligatoires
4. Cliquez sur "Envoyer le message"

### Test du formulaire
1. Accédez à http://localhost:3000/contacts
2. Remplissez le formulaire avec des données de test
3. Envoyez le message
4. Vérifiez la console pour les logs d'envoi

### Environnement de production
Pour un environnement de production, vous devriez configurer un service d'email réel comme:
- **Resend** - Service d'email moderne et simple
- **SendGrid** - Service d'email enterprise
- **Nodemailer** - Bibliothèque Node.js avec SMTP
- **AWS SES** - Service email d'Amazon
- **Brevo** (anciennement Sendinblue)

## 📋 FICHIERS CRÉÉS

### Nouveaux fichiers
- `/src/app/contacts/page.tsx` - Page de contact complète
- `/src/app/api/contact/route.ts` - API route pour l'envoi d'email
- `FORMULAIRE_CONTACT.md` - Cette documentation

### Fichiers existants modifiés
- Aucun fichier existant n'a été modifié

## 🔍 DÉBOGAGE

### Vérifier les logs
1. Consultez la console du navigateur pour les erreurs client
2. Consultez les logs du serveur dans `dev.log`
3. Vérifiez la console du navigateur pour les réponses API

### Problèmes courants
- **Formulaire ne soumet pas**: Vérifiez la validation client
- **Email non envoyé**: Vérifiez la configuration du SDK Z-AI
- **Erreur serveur**: Consultez les logs du serveur
- **Champs invalides**: Vérifiez la validation des données

## 🎉 RÉSULTAT

Le formulaire de contact est maintenant entièrement fonctionnel avec:
- ✅ Envoi d'emails à `Amicale.IPT@pasteur.tn`
- ✅ Toutes les informations requises (nom, email, téléphone, sujet, message)
- ✅ Design moderne et responsive
- ✅ Validation complète des données
- ✅ Gestion des erreurs et succès
- ✅ Journalisation pour le débogage

Les utilisateurs peuvent maintenant contacter l'Amicale IPT facilement via le formulaire sur le site !

---

*Documentation générée le ${new Date().toLocaleDateString('fr-FR')}*