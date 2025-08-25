import { db } from './src/lib/db'

async function seedDemoData() {
  console.log('Création des données de démonstration pour les résultats...')

  try {
    // D'abord, nettoyer les données existantes pour éviter les doublons
    await db.resultatAccess.deleteMany({})
    await db.resultat.deleteMany({})

    // Créer des comptes d'accès de démonstration
    const demoAccounts = [
      {
        identifiant: 'DEMO001',
        motDePasse: 'demo123'
      },
      {
        identifiant: 'DEMO002',
        motDePasse: 'demo456'
      },
      {
        identifiant: 'TEST001',
        motDePasse: 'test123'
      },
      {
        identifiant: 'PATIENT01',
        motDePasse: 'patient2024'
      }
    ]

    // Créer les comptes d'accès
    for (const account of demoAccounts) {
      await db.resultatAccess.create({
        data: {
          identifiant: account.identifiant,
          motDePasse: account.motDePasse,
          actif: true
        }
      })
    }

    // Créer les utilisateurs correspondants avec un résultat initial
    const demoUsers = [
      {
        identifiant: 'DEMO001',
        nomPrenom: 'Ahmed Ben Mohamed',
        email: 'ahmed.ben@email.com',
        telephone: '+216 22 123 456'
      },
      {
        identifiant: 'DEMO002',
        nomPrenom: 'Sonia Trabelsi',
        email: 'sonia.trabelsi@email.com',
        telephone: '+216 98 765 432'
      },
      {
        identifiant: 'TEST001',
        nomPrenom: 'Karim Jaziri',
        email: 'karim.jaziri@email.com',
        telephone: '+216 55 555 555'
      },
      {
        identifiant: 'PATIENT01',
        nomPrenom: 'Leila Ben Ali',
        email: 'leila.benali@email.com',
        telephone: '+216 77 888 999'
      }
    ]

    for (const user of demoUsers) {
      await db.resultat.create({
        data: {
          identifiant: user.identifiant,
          nomPrenom: user.nomPrenom,
          email: user.email,
          telephone: user.telephone,
          typeExamen: 'Analyse initiale',
          dateExamen: new Date(),
          dateResultat: new Date(),
          resultat: 'En attente',
          statut: 'ACTIF'
        }
      })
    }

    console.log('Données de démonstration créées avec succès!')
    console.log('Comptes de démonstration:')
    console.log('1. Identifiant: DEMO001, Mot de passe: demo123')
    console.log('2. Identifiant: DEMO002, Mot de passe: demo456')
    console.log('3. Identifiant: TEST001, Mot de passe: test123')
    console.log('4. Identifiant: PATIENT01, Mot de passe: patient2024')

  } catch (error) {
    console.error('Erreur lors de la création des données de démonstration:', error)
  }
}

seedDemoData()
  .then(() => {
    console.log('Script terminé')
    process.exit(0)
  })
  .catch((error) => {
    console.error('Erreur:', error)
    process.exit(1)
  })